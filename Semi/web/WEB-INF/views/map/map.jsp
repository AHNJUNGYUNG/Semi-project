<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.ArrayList,map.model.vo.Map"%>
<%
	ArrayList<Map> list = (ArrayList<Map>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>map</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"
>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=9u1ajgwv8z"></script>
<script src="<%=request.getContextPath()%>/tools/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/tools/MarkerClustering.js"></script>
<script src="<%=request.getContextPath()%>/tools/MarkerOverlappingRecognizer.js"></script>
<style>
* {
	font-family: 'Noto Sans KR';
}
/* a태그 설정 */
.nav a, .f2 a {
	text-decoration: none;
	color: black;
}

.nav a:hover, .f2 a:hover {
	text-decoration: none;
	color: #00B1D2;
}

/* Header */
.navbar-light {
	background-color: white;
	border-bottom: 1px solid lightgray;
	height: 89px;
}

/* Footer */
footer {
	background-color: white;
	color: black;
	border-top: 1px solid lightgray;
}

.f1 {
	display: flex;
}

.f1-col {
	flex: 1;
	font-size: 13px;
}

.f2 {
	display: flex;
	border-top: 1px solid lightgray;
	border-bottom: 1px solid lightgray;
	margin: 50px 0px 50px 0px;
	padding: 15px 0px 15px 0px;
}

.f2-col {
	flex: 1;
}

.copyright {
	color: gray;
	font-size: 13px;
}

body {
	min-height: 700px;
	display: flex;
	flex-direction: column;
}

.logo, .item {
	display: inline-block;
}

.logo>img {
	height: 72px;
	margin: 20px 0px 20px 40px;
}

.ul-item>li {
	list-style-type: none;
	display: inline-block;
	margin: 0px 10px 0px 10px;
}

.item {
	margin: auto 100px auto auto;
}

/* footer */
footer {
	text-align: center; /* position: absolute; left: 0; top: 0; width: 100%; height: 100%; */
}

#footer-name {
	display: inline-block;
	margin-right: 10px;
}

footer {
	margin-top: auto; /* 최소 높이 하단에서 자동으로 뻗어나가도록 설정 */
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>
	<!-- Page Content-->
	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<h1 class="my-4">지도로 찾기</h1>
				<div class="list-group">
					<a class="list-group-item" href='<%=request.getContextPath()%>/map.do?type=all'>전체보기</a> <a class="list-group-item"
						href='<%=request.getContextPath()%>/map.do?type=living'
					>생활체육관</a> <a class="list-group-item" href='<%=request.getContextPath()%>/map.do?type=pool'>수영장</a> <a class="list-group-item"
						href='<%=request.getContextPath()%>/map.do?type=soccer'
					>축구장</a> <a class="list-group-item" href='<%=request.getContextPath()%>/map.do?type=school'>학교체육시설</a> <a class="list-group-item"
						href='<%=request.getContextPath()%>/map.do?type=tennis'
					>테니스장</a> <a class="list-group-item" href='<%=request.getContextPath()%>/map.do?type=golf'>골프연습장</a> <a class="list-group-item"
						href='<%=request.getContextPath()%>/map.do?type=footVolley'
					>족구장</a> <a class="list-group-item" href='<%=request.getContextPath()%>/map.do?type=etc'>기타</a>
				</div>
			</div>
			<div class="col-lg-9">
				<div id="map" style="height: 850px"></div>
				<script>
					var markers = [];
					
					var seoul = new naver.maps.LatLngBounds(
					    new naver.maps.LatLng(37.413294, 127.269311),
					    new naver.maps.LatLng(37.715133, 126.734086));
					
					var map = new naver.maps.Map('map', {
						 zoom:12,
						 minZoom:11,
					     maxBounds: seoul,
					}) 
					
					function CustomMarker(lat, lng, gymID, category, gymGubun, name, address) {
						var contents_html = "";

						switch (gymGubun) {
							case "생활체육관":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#C62828; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
	
							case "수영장":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#AD1457; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							case "축구장":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#6A1B9A; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							case "학교체육시설":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#4527A0; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							case "테니스장":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#283593; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							case "골프연습장":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#1565C0; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							case "족구장":
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#0277BD; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							default : 
								contents_html = '<div style="padding-top:5px; padding-bottom:5px; padding-left:5px; padding-right:5px; background-color:#558B2F; color:white; text-align:center; border:1px solid #831616; border-radius:14px; opacity:75%" onmouseover="javascript:overGym(\''
										+ gymID
										+ '\');" onmouseout="javascript:outGym(\''
										+ gymID
										+ '\');">'
										+ '<div style="font-weight: bold; font-size:14px"> '
										+ gymGubun
										+ ' </div>'
										+ '<div style="font-weight: normal; font-size:13px; margin-top:3px; display:none" id="'+gymID+'">'
										+ name + '<br/>' + address + ' </div>';
										break;
							}
					
						var marker = new naver.maps.Marker({
							position : new naver.maps.LatLng(lat, lng),
							map : map,
							title : gymGubun,
							icon : {
								content : contents_html,
								size : new naver.maps.Size(38, 58),
								anchor : new naver.maps.Point(19, 58),
							},
							draggable : false
						});
						return marker;
					}
						<%for (int i = 0; i < list.size(); i++) {%>
							var marker<%=i%> = new CustomMarker(<%=list.get(i).getG_YCODE()%>, 
															  <%=list.get(i).getG_XCODE()%>,
															  <%=list.get(i).getG_NO()%>, 2,
															  "<%=list.get(i).getG_TYPE_NM()%>",
															  "<%=list.get(i).getG_NAME()%>",
															  "<%=list.get(i).getG_ADDRESS()%>");
							markers.push(marker<%=i%>);
						<%}%>
						
						
						$(document).ready(function() {
							var htmlMarker1 = {
									content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://navermaps.github.io/maps.js.ncp/docs/img/cluster-marker-1.png);background-size:contain;"></div>',
									size: N.Size(40, 40),
									anchor: N.Point(20, 20)
								},
								htmlMarker2 = {
									content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://navermaps.github.io/maps.js.ncp/docs/img/cluster-marker-2.png);background-size:contain;"></div>',
									size: N.Size(40, 40),
									anchor: N.Point(20, 20)
								},
								htmlMarker3 = {
									content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://navermaps.github.io/maps.js.ncp/docs/img/cluster-marker-3.png);background-size:contain;"></div>',
									size: N.Size(40, 40),
									anchor: N.Point(20, 20)
								},
								htmlMarker4 = {
									content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://navermaps.github.io/maps.js.ncp/docs/img/cluster-marker-4.png);background-size:contain;"></div>',
									size: N.Size(40, 40),
									anchor: N.Point(20, 20)
								},
								htmlMarker5 = {
									content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://navermaps.github.io/maps.js.ncp/docs/img/cluster-marker-5.png);background-size:contain;"></div>',
									size: N.Size(40, 40),
									anchor: N.Point(20, 20)
								};

								var markerClustering = new MarkerClustering({
									minClusterSize: 2,
									maxZoom: 15,
									map: map,
									markers: markers,
									disableClickZoom: false,
									gridSize: 300,
									icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
									indexGenerator: [5, 10, 15, 20, 50],
									stylingFunction: function(clusterMarker, count) {
										$(clusterMarker.getElement()).find('div:first-child').text(count);
									}
								});
						});
						
						function overGym(childID) {
							$('#' + childID).show()
						}
	
						function outGym(childID) {
							$('#' + childID).hide()
						}
				</script>
			</div>
		</div>
	</div>
	</div>
	<!-- Footer-->
	<%@ include file="../common/footer.jsp"%>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
