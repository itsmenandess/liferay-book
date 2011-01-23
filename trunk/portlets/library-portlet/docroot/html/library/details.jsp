<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@ include file="/html/library/init.jsp" %>


<%
	String backURL = ParamUtil.getString(request, "backURL");
	boolean showHeader = ParamUtil.getBoolean(request, "showHeader", true);
%>

<c:if test="<%= showHeader %>">
	<liferay-ui:header backLabel="&laquo; Back to List" title="Book Details" backURL="<%= backURL %>"/>
</c:if>

<%
	LMSBook book = null;
	long bookId = ParamUtil.getLong(request, "bookId");

	if (bookId > 0L) {
		book = LMSBookLocalServiceUtil.getLMSBook(bookId);
	}
%>

<c:if test="<%= Validator.isNotNull(book) %>">
	<table border="2">
		<tr>
			<th>Book Title</th>
			<td><%= book.getBookTitle() %></td>
		</tr>
		
		<tr>
			<th>Author</th>
			<td><%= book.getAuthor() %></td>
		</tr>
		
		<tr>
			<th>Date Added</th>
			<td>
				<fmt:formatDate value="<%= book.getDateAdded() %>" pattern="dd/MMM/yyyy"/>
			</td>
		</tr>	
		
		<tr>
			<th>Date Modified</th>
			<td>
				<fmt:formatDate value="<%= book.getDateModified() %>" pattern="dd/MMM/yyyy"/>
			</td>
		</tr>					
	</table>
</c:if>