<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%> <!-- �̰� ����Բ���� �� �ϰ�, �ִ� �� ����. -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	var menu = '${menu}';
	
	$(function() 
	{
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
				fncGetProductList(1);
		});
		
		$( ".ct_list_pop td:nth-child(3) > a" ).css("color" , "red");  //a ==> nth-child(3)�� �����ڼ�
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
      <meta charset="EUC-KR"> <!-- �굵 �־���� ��. ���� ���� ��. -->
      <title>��ǰ ����</title>
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
                                ��ǰ ����
                             </c:when>
                             <c:when test="${menu eq 'search'}">
                                ��ǰ �����ȸ
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
                 
                  <option ${! empty search.searchCondition && search.searchCondition == '0' ? 'selected' : ""} value="0">��ǰ��ȣ</option>  <!-- option�� selected�� ���� �갡 �⺻������ ������ ���� ��.  -->
                  <option ${! empty search.searchCondition && search.searchCondition == '1' ? 'selected' : ""} value="1">��ǰ��</option>
                  <option ${! empty search.searchCondition && search.searchCondition == '2' ? 'selected' : ""} value="2">��ǰ����</option>
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
                       <a href="javascript:fncGetProductList(1);">�˻�</a>-->
                       <a>�˻�</a>
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
              <td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
            </tr>
            <tr>
              <td class="ct_list_b" width="100">No</td>
              <td class="ct_line02"></td>
              <!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
                      <td class="ct_list_b" width="150">��ǰ��</td>
				////////////////////////////////////////////////////////////////////////////////////////////////// -->
              <td class="ct_list_b" width="150">
              		��ǰ��<br>
					<h7 >(��ǰ�� click:������)</h7>
			  </td>
              <td class="ct_line02"></td>
              <td class="ct_list_b" width="150">����</td>
              <td class="ct_line02"></td>
              <td class="ct_list_b">�����</td>   
              <td class="ct_line02"></td>
              <td class="ct_list_b">�������</td>   
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
                   �Ǹ���
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
                <input type="hidden" id="currentPage" name="currentPage" value="0"/>  <!-- ������ value="${resultPage.currentPage} �̰� �����ϱ� �˻��� ù��° �� �ǰ�, �ι�°�� �Ǵ� �� �ذ���. -->
                <jsp:include page="../common/pageNavigator.jsp"/>
               </td>
            </tr>
         </table>
      </form>
      </div>
   </body>
</html>