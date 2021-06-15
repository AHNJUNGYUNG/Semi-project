<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	#checkEmailContent{
		max-width: 680px;
		margin-top: 80px;
		padding: 20px;
		background: #fff;
		-webkit-border-radius: 10px;
		-moz-border-radius: 10px;
		border-radius: 10px;
		-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	}
</style>
</head>
<body>
		<div class="modal-dialog" role="document">
			<div class="modal-content" id="signUpDiv">
				<div class="modal-header">
					<div class="modal-title text-center" id="exampleModalLabel" >
						<img src="<%= request.getContextPath() %>/image/logo.png" style="height: 100px; margin-left: 150px;">
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<h3 class="my-4 text-center">회원가입</h3>
				<div class="login-form-background mx-auto row">
					<form class="validation-form" name="signUpForm" id="signUpForm" action="<%= request.getContextPath() %>/signUp.me" encType="multipart/form-data" method="post">
						<div class="mb-4">
							<div class="mb-1">
								<label for="email">이메일</label> 
								<input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
							</div>
							<div id="emailResult"></div>
						</div>
						
						<div class="mb-4">
							<div class="mb-1">
								<label for="password">비밀번호</label>
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="영문+숫자 조합 8자리 이상 입력해주세요." required>
							</div>
							<div id="pwdResult"></div>
						</div>
						
						<div class="mb-4">
							<div class="mb-1">
								<label for="password2">비밀번호 확인</label>
								<input type="password" class="form-control" id="pwd2" name="pwd2" required>
							</div>
							<div id="pwd2Result"></div>
						</div>
		
						<div class="row mb-4">
							<div class="col-md-6">
								<label for="name">이름</label>
								<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요." required>
								<div class="invalid-feedback">이름을 입력해주세요.</div>
							</div>
							<div class="col-md-6">
								<label for="gender">성별</label>
								<div class="radio">
									<label style="margin-right: 50px;">
									<input type="radio" name="gender" value="male" checked>남
									&nbsp; &nbsp;
									<input type="radio" name="gender" value="female">여
									</label>
								</div>
							</div>
						</div>

						<div class="mb-4">
							<label for="gender">대표사진</label><br>
								<img src="<%= request.getContextPath() %>/profile_uploadFiles/default_profileFile.png" class="img-fluid" id="profile_img" style="height: 100px;"> &nbsp;&nbsp;
							<div class="custom-file d-inline-block align-bottom" style="width:200px;">
								<input type="file" class="custom-file-input" id="profile" name="profile" onchange="LoadImg(this)">
								<label class="custom-file-label" for="customFile">파일선택</label>
							</div>
						</div>
		
						<div class="mb-4">
							<label for="address">주소</label>
							<input type="text" class="form-control" id="address" name="address" placeholder="서울특별시 강남구 역삼동 (동까지 기재)" required>
							<div class="invalid-feedback">주소를 입력해주세요.</div>
						</div>
		
						<div class="row mb-4">
							<div class="col-md-4">
								<label for="excersice">운동 경력</label>
								<select class="custom-select d-block w-100" id="etc" name="etc">
									<option value="경력 없음"selected>경력없음</option>
									<option value="3개월 이상">3개월 이상</option>
									<option value="6개월 이상">6개월 이상</option>
									<option value="1년 이상">1년 이상</option>
								</select>
							</div>
							<div class="col-md-8">
								<label for="favorite">선호하는 운동(선택)</label>
								<input type="text" class="form-control" id="like" name="like">
							</div>
						</div>
		
						<hr class="mb-4">
						
						<div class="custom-control custom-checkbox mb-4">
							<input type="checkbox" class="custom-control-input" id="aggrement" required>
							<label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
						</div>
						
						<div class="mb-2">
							<button class="btn btn-lg btn-block" type="submit" style="background-color: #00B1D2; color: white;">가입 완료</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
	<script>
		$(function(){
			var isEmail, isPwd, isPwd2 = false;
			
			$('#email').blur(function(){
// 				var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				
// 				if(!regExp.test($(this).val())){
// 					$("#emailResult1").text("올바른 이메일 형식이 아니에요").css("color","#dc3545");
// 					$(this).focus();
					
// 					isEmail = false;
// 				} else {
// 					$("#emailResult1").remove();
					
// 					isEmail = true;
// 				}
				
				var email = $(this).val();
				
				$.ajax({
					url: 'checkEmail.me',
					type: 'get',
					data: {inputEmail: email},
					success: function(data){
						if(data > 0){
							$("#emailResult").text('이미 가입된 이메일 입니다.').css("color","#dc3545");
							
							isEmail = false;
						} else {
							$("#emailResult").text('사용가능한 이메일 입니다.').css('color', '#28a745');	
							
							isEmail = true;
						}
					}
				});
					
			
			});
			
			$('#pwd').change(function(){
				var regExp = /^[A-Za-z][A-Za-z0-9$@$!%*#?&-_]{7,}$/;
				
				if(!regExp.test($(this).val())) {
					$("#pwdResult").text("올바른 비밀번호 형식이 아니에요.").css("color","#dc3545");
					$(this).focus();
					
					isPwd = false;
				} else {
					$("#pwdResult").remove();
					
					isPwd = true;
				}
			});
			
			$('#pwd2').change(function(){
				var pwd = $('#pwd').val();
				var pwd2 = $('#pwd2').val();
				
				if(pwd != pwd2){
					$('#pwd2Result').text('비밀번호가 일치하지 않아요.').css("color","#dc3545");
					$(this).focus();
					
					isPwd2 = false;
				} else {
					$('#pwd2Result').text('비밀번호가 일치합니다.').css('color','#28a745');
					
					isPwd2 = true;
				}
			});
						
			$('#signUpForm').submit(function(){
				console.log('회원가입 submit');
				
				if(isEmail && isPwd && isPwd2 == true){
				 	alert('반갑습니다');
				 	
					return true;
				} else {
					if(!isEmail){
						alert('이메일을 확인해주세요');
						$('#email').focus();
					}
					else if(!isPwd){
						$('#pwd').focus();
					}
					else if(!isPwd2){
						$('#pwd2').focus();
					}
					
					return false;
				}
			});
		});
		
		function LoadImg(value){
			
			if(value.files && value.files[0]){
				var reader = new FileReader();
				
				reader.onload = function(e){								
					$("#profile_img").attr("src", e.target.result);
				}
				
				reader.readAsDataURL(value.files[0]);	
			}
		}
		
		
	</script>

</body>
</html>