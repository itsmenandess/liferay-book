<%@ include file="/html/library/init.jsp" %>

<h1>Add / Edit Form</h1>

<% 
	PortletURL updateBookURL = renderResponse.createActionURL();
	updateBookURL.setParameter(ActionRequest.ACTION_NAME, "updateBook");
%>

<%-- 
<form name="<portlet:namespace/>fm" method="POST" action="<%= updateBookURL.toString() %>">
	Book Title: <input type="text" name="<portlet:namespace/>bookTitle" />
	<br/>Author: <input type="text" name="<portlet:namespace/>author" />
	<br/><input type="submit" value="Save" />
</form>
--%>

<aui:form name="fm" method="POST" action="<%= updateBookURL.toString() %>" onSubmit="<%= updateBookURL.toString() %>">
	<aui:input type="hidden" name="redirectURL" value="<%= renderResponse.createRenderURL().toString() %>"/>
	<aui:input name="bookTitle" label="Book Title"/>
	<aui:input name="author"/>
	<aui:button type="submit" value="Save"/>
</aui:form>

<br/><a href="<portlet:renderURL/>">&laquo; Go Back</a>

<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery("#<portlet:namespace/>fm").validate();
	  	jQuery("#<portlet:namespace/>bookTitle").addClass("required");
	  	jQuery("#<portlet:namespace/>author").addClass("required");
	});
</script>