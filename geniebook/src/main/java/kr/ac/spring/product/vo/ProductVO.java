package kr.ac.spring.product.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

@Component("productVO")
public class ProductVO {
	private int bookNo;
	private String category;
	private String bookName;
	private String writer;
	private String publisher;
	private Date pubYear;
	private int price;
	private int stock;
	private String description;
	private String imageFileName;

	// Constructors
	public ProductVO() {
	}

	public ProductVO(String bookName, String category, String writer, String publisher, Date pubYear, int price,
			int stock, String description) {
		this.bookName = bookName;
		this.category = category;
		this.writer = writer;
		this.publisher = publisher;
		this.pubYear = pubYear;
		this.price = price;
		this.stock = stock;
		this.description = description;
	}

	/**
	 * @param bookNo
	 * @param category
	 * @param bookName
	 * @param writer
	 * @param publisher
	 * @param pubYear
	 * @param price
	 * @param stock
	 * @param imageFileName
	 */
	public ProductVO(int bookNo, String category, String bookName, String writer, String publisher, Date pubYear,
			int price, int stock, String imageFileName, String description) {
		this(bookName, category, writer, publisher, pubYear, price, stock, description);
		this.bookNo = bookNo;
		this.imageFileName = imageFileName;
	}
	
	@Override
	public String toString() {
		return "ProductVO [bookNo=" + bookNo + ", category=" + category + ", bookName=" + bookName + ", writer="
				+ writer + ", publisher=" + publisher + ", pubYear=" + pubYear + ", price=" + price + ", stock=" + stock
				+ ", description=" + description + ", imageFileName=" + imageFileName + "]";
	}

	// setters and getters
	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public String getCategory() {
		return category;
	}

	public void setProperty(String property, Object object) throws ParseException {
		if (property.equals("bookName")) {
			this.bookName = (String) object;
		} else if (property.equals("category")) {
			this.category = (String) object;
		} else if (property.equals("writer")) {
			this.writer = (String) object;
		} else if (property.equals("publisher")) {
			this.publisher = (String) object;
		} else if (property.equals("pubYear")) {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse((String) object);
			this.pubYear = date;
		} else if (property.equals("price")) {
			this.price = Integer.parseInt(object.toString());
		} else if (property.equals("stock")) {
			this.stock = Integer.parseInt(object.toString());
		} else if(property.equals("description")) {
			this.description = (String) object;
		} else if(property.equals("bookNo")) {
			this.bookNo = Integer.parseInt(object.toString());
		} else if(property.equals("imageFileName")) {
			this.imageFileName = (String) object;
		}
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public Date getPubYear() {
		return pubYear;
	}

	public void setPubYear(Date pubYear) {
		this.pubYear = pubYear;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getimageFileName() {
		return imageFileName;
	}

	public void setimageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

}
