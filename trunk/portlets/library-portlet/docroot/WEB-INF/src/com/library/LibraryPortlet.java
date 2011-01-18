package com.library;

import java.io.IOException;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;

import com.library.slayer.model.LMSBook;
import com.library.slayer.model.impl.LMSBookImpl;
import com.library.slayer.service.LMSBookLocalServiceUtil;
import com.liferay.counter.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class LibraryPortlet
 */
public class LibraryPortlet extends MVCPortlet {

	public void updateBook(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
		
		String bookTitle = ParamUtil.getString(actionRequest, "bookTitle");
		String author = ParamUtil.getString(actionRequest, "author");
		
		
		LMSBook book = new LMSBookImpl();
		
		// set primary key
		long bookId = 0L;
		try {
			bookId = 
				CounterLocalServiceUtil.increment(
						this.getClass().getName());
		} catch (SystemException e) {
			e.printStackTrace();
		}
		book.setBookId(bookId);
		
		// set UI fields
		book.setBookTitle(bookTitle);
		book.setAuthor(author);
		
		// set audit field(s)
		book.setDateAdded(new Date());
		
		// insert the book using persistence api
		try {
			LMSBookLocalServiceUtil.addLMSBook(book);
		} catch (SystemException e) {
			e.printStackTrace();
		}
	}
}
