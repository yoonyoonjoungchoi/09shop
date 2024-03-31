<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>Model2 MVC Shop</title>

	<link href="/css/left.css" rel="stylesheet" type="text/css">
	
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

		//==> jQuery 적용 추가된 부분
		 $(function() {
			 
			//==> 개인정보조회 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( ".Depth03:contains('개인정보조회')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('개인정보조회')" ).html() );
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
			});
			
			
			//==> 회원정보조회 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( ".Depth03:contains('회원정보조회')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('회원정보조회')" ) );
		 		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
			}); 
			
			
		 	$( ".Depth03:contains('판매상품등록')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('판매상품등록')" ) );
		 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/addProductView.jsp");
			}); 
		 	
		 	
			$( ".Depth03:contains('판매상품관리')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('판매상품관리')" ) );
		 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
			}); 
			
		 	
		 	$( ".Depth03:contains('상품검색')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('상품검색')" ) );
		 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
			}); 
		 	
		 	
			$( ".Depth03:contains('최근 본 상품')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('최근 본 상품')" ) );
		 		//$(window.parent.frames["rightFrame"].document.location).attr("href", "javascript:history()");
				popWin = window.open("/history.jsp",  //얘만 이렇게 형식 다른 이유=>얘만 javascript라서. 윙
						"popWin",
						"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no"); //팝업창이 열리는 소스. 원래는 얘가 거의 맨 위에 있었음. history(); 안에 (메소드처럼(?) 들어있어서 대기함. 대기하고 있다가 클릭하면 팝업창을 띄워줌. 
			}); 																																			//지금 바꾼 형태: 이벤트가 발생하면 어떻게 할지 이벤트 처리기(?)처럼 만들어놓음. 클릭하면 팝업창 띄워줌. 
			
			
		
			
		});	
		 
	</script>
	
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">
							<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
							<a href="/user/getUser?userId=${user.userId}" target="rightFrame">개인정보조회</a>	
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
							개인정보조회
						</td>
					</tr>
				</c:if>
			
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
							<a href="/user/listUser" target="rightFrame">회원정보조회</a>	
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
							회원정보조회
						</td>
					</tr>
				</c:if>
			
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
		</table>
	</td>
</tr>

<!--menu 02 line-->
<c:if test="${user.role == 'admin'}">
	<tr>
		<td valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						<!--  <a href="/product/addProductView.jsp;" target="rightFrame">판매상품등록</a>-->
						판매상품등록
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						<!-- <a href="/product/listProduct?menu=manage"  target="rightFrame">판매상품관리</a>-->
						판매상품관리
					</td>
				</tr>
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					<!--  <a href="/product/listProduct?menu=search" target="rightFrame">상 품 검 색</a>  --> 
					상품검색
				</td>
			</tr>
			
			<c:if test="${ !empty user && user.role == 'user'}">
			<tr>
				<td class="Depth03">
					<!--  <a href="/listPurchase"  target="rightFrame">구매이력조회</a>-->
					구매이력조회
				</td>
			</tr>
			</c:if>
			
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">
				  <!-- <a href="javascript:history()">최근 본 상품</a> -->
				최근 본 상품
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>

</html>