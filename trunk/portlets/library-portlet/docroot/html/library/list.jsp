<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@ include file="/html/library/init.jsp" %>

<h1>List of books in our Library</h1>

<%
	int count = LMSBookLocalServiceUtil.getLMSBooksCount();
	List<LMSBook> books = LMSBookLocalServiceUtil.getLMSBooks(0, count);
%>

<%-- 
<table border="1" width="80%">
	<tr>
		<th>Book Title</th>
		<th>Author</th>
		<th>Date Added</th>
	</tr>
	
	<% 
		for (LMSBook book : books) {
			%>
				<tr>
					<td><%= book.getBookTitle() %></td>
					<td><%= book.getAuthor() %></td>
					<td><%= book.getDateAdded() %></td>
				</tr>
			<%
		}
	%>
</table>
--%>

<%
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("jspPage", "/html/library/list.jsp");
	
	PortletURL deleteBookURL = renderResponse.createActionURL();
	deleteBookURL.setParameter(ActionRequest.ACTION_NAME, "deleteBook");
	deleteBookURL.setParameter("redirectURL", iteratorURL.toString());
	
	PortletURL detailsURL = renderResponse.createRenderURL();
	detailsURL.setParameter("jspPage", "/html/library/details.jsp");
%>

<liferay-ui:search-container delta="4" iteratorURL="<%= iteratorURL %>" 
	emptyResultsMessage="Sorry. There are no items to display.">

	<liferay-ui:search-container-results 
		total="<%= books.size() %>"
		results="<%= ListUtil.subList(books, searchContainer.getStart(), searchContainer.getEnd()) %>"
	/>
		
	<liferay-ui:search-container-row modelVar="book" 
		className="com.library.slayer.model.LMSBook">
		
		<% 
			detailsURL.setParameter("bookId", String.valueOf(book.getBookId()));
			detailsURL.setParameter("backURL", themeDisplay.getURLCurrent());
		%>
		<liferay-ui:search-container-column-text name="Book Title">
			<aui:a href="<%= detailsURL.toString() %>"><%= book.getBookTitle() %></aui:a>
		</liferay-ui:search-container-column-text>
		<liferay-ui:search-container-column-text name="Author" property="author" />
		<liferay-ui:search-container-column-text name="Date Added">
			<fmt:formatDate value="<%= book.getDateAdded() %>" pattern="dd/MMM/yyyy"/>
		</liferay-ui:search-container-column-text>
		
		<% deleteBookURL.setParameter("bookId", String.valueOf(book.getBookId())); %>
		<liferay-ui:search-container-column-text name="Delete">
			<a href="<%= deleteBookURL.toString() %>">Delete &raquo;</a>
		</liferay-ui:search-container-column-text>
		
		<liferay-ui:search-container-column-jsp name="Actions" 
			path="/html/library/actions.jsp" />
		
	</liferay-ui:search-container-row>
	
	<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

</liferay-ui:search-container>

<br/><a href="<portlet:renderURL/>">&laquo; Go Back</a>