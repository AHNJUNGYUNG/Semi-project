<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Member mem = (Member)request.getAttribute("member"); 
	String email = mem.getM_email();
	String pwd = mem.getM_pwd();
	String name = mem.getM_name();
	String address = mem.getM_address();
	char gender = mem.getM_gender(); // 남자 : m 여자 : f	
	
	String etc = mem.getM_etc();
	String[] selectEtc = new String[3];
	switch(etc) {
	case "3개월 이상": selectEtc[0] = "selected"; break;
	case "6개월 이상": selectEtc[1] = "selected"; break;
	case "1년 이상": selectEtc[2] = "selected"; break;
	}
	
	String like = mem.getM_like();
	String[] selectLike = new String[8];
	switch(like) {
	case "수영": selectLike[0] = "selected"; break;
	case "축구": selectLike[1] = "selected"; break;
	case "테니스": selectLike[2] = "selected"; break;
	case "골프": selectLike[3] = "selected"; break;
	case "족구": selectLike[4] = "selected"; break;
	case "배드민턴": selectLike[5] = "selected"; break;
	case "농구": selectLike[6] = "selected"; break;
	case "풋살": selectLike[7] = "selected"; break;
	}
%>
<!DOCTYPE html>
<html>
<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>마이페이지 - 회원 정보 수정</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
       <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
		<style>
			*{font-family: 'Noto Sans KR';}
			
			.side:hover{cursor: pointer; color: #00B1D2;}			
			
 			.page {margin-bottom: 50px;} 
	 		
 	 		.pagination { 
 		 		list-style-type: none; 
 				display: block; 
 				text-align: center; 
	 		
 		 	} 
		 	
 		 	.page-item { 
 				display: inline-block; 
 		 		padding: 0.2rem; 
		 				
 		 	} 		 	 
		 	 
		 	.title {margin-top: 50px; margin-bottom: 20px;}
		 	
		 	.list-group{width: 230px; padding-top: 40px;}
		 	.list-group-item{color: black;}
		 	
		 	th {
		 	 	background: lightgrey;
		 	 	border-top: 1px solid grey;
		 	 }
		 	 
		 	 td, th {
		 	 	border-bottom: 1px solid grey; 	 	
		 	 }
		 	 
		 	 table {
		 	 	width: 100%;
		 	 	height: 400px;
		 	 	text-align: center;
		 	 }
		 	 
		 	 .correctButton, #delete {
		 	 	color: white;
		 	 	background: #00b1d2;
		 	 	border: none;
		 	 	border-radius: 10px;
		 	 	padding: 0.3rem;
		 	 	padding-left: 0.7rem;
		 	 	padding-right: 0.7rem;
		 	 	font-size: 10pt;
		 	 	font-weight: bold;
		 	 }
			
			 #delete{
	         	margin: 20px;
	         	float: right;
	         }
 		
		</style>
<body>

	<%@include file="../common/header.jsp" %>
	
	<div class="container" >
		<div class="row">
			<div class="col-lg-3">                   
            	<div class="list-group">
                	<div class="list-group-item" style="font-weight:bold;">마이페이지</div>
						<div class="list-group-item side" id="memberUpdateForm">회원정보 수정</div>
                        <div class="list-group-item side" id="myFavorites">즐겨찾기</div>
                        <div class="list-group-item side" id="myReview">리뷰 관리</div>
                        <div class="list-group-item side" id="myBoard">게시물 관리</div>
                        <div class="list-group-item side" id="myComment">댓글 관리</div>
                    </div>
                </div>
            	<div class="col-lg-9" id="loadContent">
					<div class="input-form-backgroud row" style="margin-top: 50px; margin-bottom: 100px;">
						<div class="input-form mx-auto">
							<h4 class="mb-3 text-center">회원정보 수정</h4>
							<form class="validation-form" name="updateMemberForm" id="updateMemberForm" action="<%= request.getContextPath() %>/update.me" method="post" encType="multipart/form-data">
								<div class="mb-3">
									<label for="gender">대표사진 변경</label><br>
										<img src="<%= request.getContextPath() %>/profile_uploadFiles/<%= mem.getM_profile() %>" class="img-fluid" style="height: 100px;"> &nbsp;
									<div class="custom-file d-inline-block align-bottom" style="width:200px;">
										<input type="file" class="custom-file-input" id="updateProfile" name="updateProfile" onchange="LoadImg(this);">
										<label class="custom-file-label" for="customFile">파일선택</label>
									</div>
								</div>
								
								<div class="mb-3">
									<label for="email">이메일</label> 
									<input type="email" class="form-control" id="email" name="email" value="<%= email %>" readonly>
								</div>
			
								<div class="mb-3">
									<label for="pwd">비밀번호 변경</label>
									<span class="pwdConfirm" style="font-size:10pt; font-weight:bold;"></span>
									<input type="password" class="form-control" id="pwd" name="pwd" placeholder="변경할 비밀번호를 입력해주세요.">
								</div>
				
								<div class="mb-3">
									<label for="pwd2">비밀번호 확인</label>					
									<input type="password" class="form-control" id="pwd2" name="pwd2">
								</div>
				
								<div class="row mb-3">
									<div class="col-md-6">
										<label for="name">이름</label>
										<input type="text" class="form-control" id="name" name="name" value="<%= name %>" readonly>
									</div>
									<div class="col-md-6">
										<label for="gender">성별</label>
										<div class="radio">
											<label style="margin-right: 50px;">
											<input type="radio" name="gender" value="man" id="man">남
											&nbsp; &nbsp;
											<input type="radio" name="gender" value="female" id="female">여
											</label>
										</div>
									</div>
								</div>
				
								<div class="mb-3">
									<label for="updateAddress">주소 변경을 위해 새로운 주소를 입력해주세요</label>
									<input type="text" class="form-control" id="updateAddress" name="updateAddress" placeholder="서울특별시 강남구 역삼동 (동까지 기재)" value="<%= address %>"required>
								</div>
				
								<div class="row mb-3">
									<div class="col-md-4">
										<label for="updateEtc">운동 경력</label>
										<select class="custom-select d-block w-100" id="updateEtc" name="updateEtc">
											<option value="경력없음" selected>경력없음</option>
											<option value="3개월 이상" <%=selectEtc[0] %>>3개월 이상</option>
											<option value="6개월 이상" <%=selectEtc[1] %>>6개월 이상</option>
											<option value="1년 이상" <%=selectEtc[2] %>>1년 이상</option>
										</select>
									</div>
									<div class="col-md-8">
								<label for="updateLike">선호하는 운동</label>	
								<select class="custom-select d-block w-100" id="updateLike" name="updateLike">
									<option value="없음" selected>없음</option>
									<option value="수영" <%= selectLike[0] %>>수영</option>
									<option value="축구" <%= selectLike[1] %>>축구</option>
									<option value="테니스" <%= selectLike[2] %>>테니스</option>
									<option value="골프" <%= selectLike[3] %>>골프</option>
									<option value="족구" <%= selectLike[4] %>>족구</option>
									<option value="배드민턴" <%= selectLike[5] %>>배드민턴</option>
									<option value="농구"<%= selectLike[6] %>>농구</option>
									<option value="풋살" <%= selectLike[7] %>>풋살</option>
								</select>
							</div>
								</div>
				
								<hr class="mb-4">
								<div class="mb-4">
									<button class="btn btn-lg btn-block" type="submit" style="background-color: #00B1D2; color: white;">수정 완료</button>
								</div>
								
								<div class="text-right">
								<span style="font-size: 15px;">탈퇴를 원하시면 회원 탈퇴 버튼을 눌러주세요.</span>
								<button class="btn btn-sm" type="button" style="background-color: #00B1D2; color: white;" id="deleteMemberBtn">회원 탈퇴</button>
								</div>
							</form>
								
						</div>
					</div>
            	</div>
		</div>
	</div>       

	<%@include file="../common/footer.jsp" %>
	
	<script>
		$(document).ready(function(){
			$('#memberUpdateForm').click(function(){
				location.href="myPage.me";
			});
			
			$('#myBoard').click(function(){
				location.href="myBoardList.me";
			});
									
			$('#myReview').click(function(){
				location.href="myReviewList.me";
			});
			
			$('#myComment').click(function(){
				location.href="myCommentList.me";
			});
			
			$('#myFavorites').click(function(){
				location.href="myFavoritesList.me";
			});
			
		});
		
		$('#deleteMemberBtn').on('click', function(){
			var check = window.confirm("정말 탈퇴하시겠습니까?");
			
			if(check) {
				$('#updateMemberForm').attr('action', "<%= request.getContextPath() %>/delete.me");
				$('#updateMemberForm').submit();
				alert("탈퇴가 완료되었습니다.");
			}
			
		});
		
		if('<%=gender%>' == 'm') {
			$('#man').prop('checked', true);
		} else {
			$('#female').prop('checked', true);
		}
		
		function LoadImg(value) {
			if(value.files && value.files[0]) {
				var reader = new FileReader();
				
				reader.onload = function(e) {
					$('.img-fluid').attr('src', e.target.result);
				}
				
				reader.readAsDataURL(value.files[0]);
			}
		}
		
		$(function(){
			var pwd = true;
			var pwd2 = true;
		
			
			$('#pwd').change(function(){
				// 비밀번호 형식 확인
				var regExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
				
				if(regExp.test($(this).val())) {
					$('.pwdConfirm').text(" ");
					pwd = true;
					pwd2  = false;
				} else {
					$('.pwdConfirm').text("영문 + 숫자 8자 이상 입력").css("color", "#dc3545");
					$('#pwd').focus();
					
					pwd = false;
				}
			});
			
			// 비밀번호 일치 여부
			$('#pwd2').change(function(){
				
				if($('#pwd').val() == $(this).val()) {
					$('.pwdConfirm').text("비밀번호가 일치합니다.").css("color","#28a745");					
					pwd2 = true;
													
				} else {
				
					$('.pwdConfirm').text("비밀번호가 일치하지 않습니다.").css("color","#dc3545");
					$(this).focus();
					
					pwd2 = false;		
				}
			});
			
			$('#updateMemberForm').submit(function(){
				
				if(pwd && pwd2) {
					return true;
				} else {
					if(!pwd || !pwd2) {
						alert('비밀번호를 확인해주세요.');
					}
					
					return false;
				}
			});
			
		});
	</script>
</body>
</html>