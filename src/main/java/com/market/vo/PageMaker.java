package com.market.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	/* 아래 변수는 게시판 하단에 있는 버튼들을 나타내는 것 ( <<  <  1  2  3  4  5  6  7  8  9  10  >  >> )*/ 
	
	private int page=1;//현재 페이지 (지금 내가 들어와 있는 페이지)
	private int perPageNum=10;//페이지당 데이터 개수
	private String searchType;//검색할 컬럼
	private String keyword;//검색 내용
	
	private int totalCount;//전체데이터 개수
	private int totalStartPage=1;//전체의 처음 페이지 번호 ( << 버튼을 만드는 것)
	private int totalEndPage;//전체의 마지막 페이지 번호 ( >> 버튼을 만드는 것)
	private int startPage;//pageMake에서 화면에 보여줄  시작 페이지 번호 (1, 11, 21 같이 < 또는 >을 넣었을 때 나오는 값중 첫번째 값)
	private int endPage;//pageMaker에서 화면에 보여줄 마지막 페이지 번호 (10, 20, 20 같이 < 또는 >을 넣었을 때 나오는 값중 마지막 값)
	private boolean prev;//이전 페이지 번호 목록 이동 ( < 버튼을 만드는 것)
	private boolean next;//다음 페이지 목록 이동 ( > 버튼을 만드는 것)
	private int displayPageNum = 10;//pageMaker에서 사용자에게 제공하는 한 화면에서 보여줄 페이지 개수
	
	private int pCode;
	
	public int getTotalStartPage() {
		return totalStartPage;
	}
	public void setTotalStartPage(int totalStartPage) {
		this.totalStartPage = totalStartPage;
	}
	public int getTotalEndPage() {
		return totalEndPage;
	}
	public void setTotalEndPage(int totalEndPage) {
		this.totalEndPage = totalEndPage;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page<=0) {
			page=1;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum<=0||perPageNum>100) {
			perPageNum=10;
		}
		this.perPageNum = perPageNum;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		//전체 개수를 설정한다음 페이징에 필요한 데이터 값을 생성
		//할 수 있다.
		calcData();
	}
	private void calcData() {
		totalStartPage=1;
		totalEndPage=(int)Math.ceil(totalCount/(double)perPageNum);
//		private int endPage;//pageMaker에서 마지막 페이지 번호 (Math.ceil = 올림)
	    endPage = (int) (//올림 floor 내림 round 반올림
	    		Math.ceil(page /(double) displayPageNum)
	    		* displayPageNum);
//	    private int startPage;//pageMake에서 시작 페이지 번호
	    startPage=endPage-displayPageNum+1;
	    if(totalEndPage < endPage) {
	    	endPage=totalEndPage;
	    }
	    
	    if(startPage<1) {
	    	startPage=1;
	    }
	    if(startPage==1) {
	    	prev=false;
	    }else {
	    	prev=true;
	    }
	    if(endPage==totalEndPage) {
	    	next=false;
	    }else {
	    	next=true;
	    }

//		private boolean prev;//이전 페이지 번호 목록 이동
//		private boolean next;//다음 페이지 목록 이동
		
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	@Override
	public String toString() {
		return "PageMaker [page=" + page + ", perPageNum=" + perPageNum + ", searchType=" + searchType + ", keyword="
				+ keyword + ", totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", prev=" + prev + ", next=" + next + "]";
	}
	
	public String makeSearch() {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword)
				.build();
		return u.toUriString();		
	}
	
	public String makeSearch(int page) {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword)
				.build();
		return u.toUriString();		
	}
	public String makePage(int page) {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.build();
		return u.toUriString();	//문자열을 만들어주는 소스
	}
	
	
	public int getpCode() {
		return pCode;
	}
	public void setpCode(int pCode) {
		this.pCode = pCode;
	}
	
	
}
















