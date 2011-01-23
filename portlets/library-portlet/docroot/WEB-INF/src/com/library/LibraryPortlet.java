package com.library;

import java.io.IOException;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;

import com.library.slayer.model.LMSBook;
import com.library.slayer.model.impl.LMSBookImpl;
import com.library.slayer.service.LMSBookLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
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
		
		long bookId = ParamUtil.getLong(actionRequest, "bookId");
		
		LMSBook book = null;
		if (bookId > 0L) {
			try {
				book = LMSBookLocalServiceUtil.getLMSBook(bookId);
			} catch (PortalException e) {
				e.printStackTrace();
			} catch (SystemException e) {
				e.printStackTrace();
			}
		} else {
			book = new LMSBookImpl();
		}
			
				
		// set UI fields
		book.setBookTitle(bookTitle);
		book.setAuthor(author);
		
		if (bookId > 0L) {
			modifyBook(book);
		} else {
			addBook(book);
		}
		
		// gracefully redirecting to the default portlet view
		String redirectURL = ParamUtil.getString(actionRequest, "redirectURL");
		actionResponse.sendRedirect(redirectURL);
		
	}

	private void addBook(LMSBook book) {
		// set audit field(s)
		book.setDateAdded(new Date());
		
		// insert the book using persistence api
		try {
			LMSBookLocalServiceUtil.addLMSBook(book);
		} catch (SystemException e) {
			e.printStackTrace();
		}
	}
	
	private void modifyBook(LMSBook book) {
		
		book.setDateModified(new Date());
		
		try {
			LMSBookLocalServiceUtil.updateLMSBook(book);
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteBook(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
	
		long bookId = ParamUtil.getLong(actionRequest, "bookId");
		
		if (bookId > 0L) {
			try {
				LMSBookLocalServiceUtil.deleteLMSBook(bookId);
			} catch (PortalException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// gracefully redirecting to the default portlet view
		String redirectURL = ParamUtil.getString(actionRequest, "redirectURL");
		actionResponse.sendRedirect(redirectURL);
	}
}
