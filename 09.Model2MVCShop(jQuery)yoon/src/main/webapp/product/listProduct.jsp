<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%> <!-- 이거 강사님꺼대로 안 하고, 넣는 게 좋음. -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	var menu = '${menu}';
	
	$(function() 
	{
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				fncGetProductList(1);
		});
		
		$( ".ct_list_pop td:nth-child(3) > a" ).css("color" , "red");  //a ==> nth-child(3)의 일촌자손
		$( ".ct_list_pop td:nth-child(3) > a" ).css("cursor" , "pointer");
		$("h7").css("color" , "red");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		$( ".ct_list_pop td:nth-child(3) > a" ).on("click" , function() 
		{
			if(menu == 'manage')
			{
				self.location ="/product/updateProduct?prodNo="+$(this).parent().children('input').val()+"&menu="+menu;	
			}else
			{
				self.location ="/product/getProduct?prodNo="+$(this).parent().children('input').val()+"&menu="+menu;
			}
		});
	});	
	
   function fncGetProductList(currentPage)
   {
	 //document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)   
		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
	}
   
</script>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="EUC-KR"> <!-- 얘도 넣어줘야 함. 보험 같은 것. -->
      <title>상품 관리</title>
      <link rel="stylesheet" href="/css/admin.css" type="text/css">
   </head>
   <body bgcolor="#ffffff" text="#000000">
      <div style="width:98%; margin-left:10px;">
      <form name="detailForm">
      	<!-- <input type="hidden" name="menu" value="${menu}">  -->
         <table width="100%" height="37" border="0" cellpadding="0"   cellspacing="0">
            <tr>
              <td width="15" height="37">
                <img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
              </td>
              <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td width="93%" class="ct_ttl01">
                       <c:if test="${!empty menu}">
                          <c:choose>
                             <c:when test="${menu eq 'manage'}">
                                상품 관리
                             </c:when>
                             <c:when test="${menu eq 'search'}">
                                상품 목록조회
                             </c:when>
                          </c:choose>
                       </c:if>
                     </td>
                  </tr>
                </table>
              </td>
              <td width="12" height="37">
                <img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
              </td>
            </tr>
         </table>

         <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
            <tr>
              <td align="right">
                <select name="searchCondition" class="ct_input_g" style="width:80px">
                 
                  <option ${! empty search.searchCondition && search.searchCondition == '0' ? 'selected' : ""} value="0">상품번호</option>  <!-- option에 selected가 들어가면 얘가 기본적으로 선택한 값이 됨.  -->
                  <option ${! empty search.searchCondition && search.searchCondition == '1' ? 'selected' : ""} value="1">상품명</option>
                  <option ${! empty search.searchCondition && search.searchCondition == '2' ? 'selected' : ""} value="2">상품가격</option>
                </select>
                <input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value="${search.searchKeyword}" />
              </td>
              <td align="right" width="70">
                <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td width="17" height="23">
                       <img src="/images/ct_btnbg01.gif" width="17" height="23">
                     </td>
                     <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
                     <!--  
                       <a href="javascript:fncGetProductList(1);">검색</a>-->
                       <a>검색</a>
                     </td>
                     <td width="14" height="23">
                       <img src="/images/ct_btnbg03.gif" width="14" height="23">
                     </td>
                  </tr>
                </table>
              </td>
            </tr>
         </table>

         <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
            <tr>
              <td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지</td>
            </tr>
            <tr>
              <td class="ct_list_b" width="100">No</td>
              <td class="ct_line02"></td>
              <!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
                      <td class="ct_list_b" width="150">상품명</td>
				////////////////////////////////////////////////////////////////////////////////////////////////// -->
              <td class="ct_list_b" width="150">
              		상품명<br>
					<h7 >(상품명 click:상세정보)</h7>
			  </td>
              <td class="ct_line02"></td>
              <td class="ct_list_b" width="150">가격</td>
              <td class="ct_line02"></td>
              <td class="ct_list_b">등록일</td>   
              <td class="ct_line02"></td>
              <td class="ct_list_b">현재상태</td>   
            </tr>
            <tr>
              <td colspan="11" bgcolor="808285" height="1"></td>
            </tr>
            
              <c:set var="i" value="0" />
              <c:forEach var="product" items="${list}">
                 <c:set var="i" value="${ i+1 }" />
                 <tr class="ct_list_pop">
                   <td align="center">${ i }</td>
                   <td></td>
                   <td align="left">
	               	<a>${product.prodName}</a>
	                <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
                    </td>
                 <td></td>
                 <td align="left">${product.price}</td>
                 <td></td>
                 <td align="left">${product.regDate}</td>
                 <td></td>
                 <td align="left">
                   판매중
                 </td>   
               </tr>
               <tr>
                 <td colspan="11" bgcolor="D6D7D6" height="1"></td>
               </tr>   
            </c:forEach>
         </table>
            
         <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
            <tr>
              <td align="center">
                <input type="hidden" id="currentPage" name="currentPage" value="0"/>  <!-- 마지막 value="${resultPage.currentPage} 이거 넣으니까 검색어 첫번째 안 되고, 두번째에 되던 거 해결함. -->
                <jsp:include page="../common/pageNavigator.jsp"/>
               </td>
            </tr>
         </table>
      </form>
      </div>
   </body>
</html>