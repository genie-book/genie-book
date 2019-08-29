package kr.ac.spring.review.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.spring.review.service.ReviewService;
import kr.ac.spring.review.vo.ReviewVO;

@RestController("reviewController")
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@Inject
	public ReviewController(ReviewService reviewService) {
		this.reviewService = reviewService;
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> insertReview(@RequestBody ReviewVO reviewVO){
		ResponseEntity<String> entity = null;
		try {
			reviewService.insertReview(reviewVO);
			entity = new ResponseEntity<>("insertSuccess",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/all/{bookNo}", method = RequestMethod.GET)
	public ResponseEntity<List<ReviewVO>> listReviews(@PathVariable("bookNo") int bookNo){
		ResponseEntity<List<ReviewVO>> entity = null;
		try {
			entity = new ResponseEntity<>(reviewService.selectReviewByBookNo(bookNo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{reviewId}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> updateReview(@PathVariable("reviewId") int reviewId, @RequestBody ReviewVO reviewVO){
		ResponseEntity<String> entity = null;
		try {
			reviewService.updateReview(reviewVO);
			entity = new ResponseEntity<>("updateSuccess",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{reviewId}", method=RequestMethod.DELETE)
	public ResponseEntity<String> deleteReview(@PathVariable("reviewId") int reviewId){
		ResponseEntity<String> entity = null;
		try {
			reviewService.deleteReview(reviewId);
			entity = new ResponseEntity<>("deleteSuccess",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
