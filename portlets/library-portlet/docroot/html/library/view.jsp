<%@ include file="/html/library/init.jsp" %>

Welcome to our library

<portlet:renderURL var="updateBookURL">
	<portlet:param name="jspPage" value="/html/library/update.jsp"/>
</portlet:renderURL>

<br/><a href="<%= updateBookURL %>">Add new Book &raquo;</a>
