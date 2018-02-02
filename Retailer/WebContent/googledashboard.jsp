<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mongodb.*"%>
<%@page import="java.net.UnknownHostException"%>
<%@page isELIgnored="false"%>
<%@page import="java.util.List"%> 
<%@page import="java.util.Arrays"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>Disaster Details</title>
<!-- //{pageContext.request.contextPath} -->
<link href="/style.css" rel="stylesheet" type="text/css" />
<link href="/datePicker.css" rel="stylesheet" type="text/css" />
<link href="/style.css" rel="stylesheet" type="text/css" />
<script src="jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="jquery.datePicker-min.js" type="text/javascript"></script>
<script src="maps.google.js" type="text/javascript"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9deHAUnAxQmzTTp0QtTVa8ZvWzgfBaaE"></script>
<script type="text/javascript" src="./js/markerclusterer.js" /></script>
<script type="text/javascript" src="./js/markerwithlabel.js" /></script>
</head>
<body>
	<div id="wrapper" style="border: solid 0px #F1F1F1; margin-top: 0px; margin-left: -279px;padding: 5px;">
		<div style="border: solid 1px #CCCCCC; height: 50px;">
<%
//Connection con=null;
String[][] sa1=null;
MongoClient mongoClient = new MongoClient("localhost", 27017);
DB database = mongoClient.getDB("Retailer");
DBCollection collection =  database.getCollection("latlngcol");
DBCursor cursor = collection.find(); 

List<String> listString = new ArrayList<String>();
while(cursor.hasNext())
 {
	String val = new String();
	List<String> valString = new ArrayList<String>();
	valString.add(cursor.next().toString());
	
	listString.addAll(valString);
	} 

%>

<% System.out.println("lat lng table data:" +listString);%>

<% 
DB database1 = mongoClient.getDB("Retailer");
DBCollection collection1 =  database1.getCollection("retailercol");
DBCursor cursor1 = collection1.find(); 

List<String> listString1 = new ArrayList<String>();
int count=0;
while(cursor1.hasNext())
 {
	
	String val1 = new String();
	List<String> valString1 = new ArrayList<String>();
	valString1.add(cursor1.next().toString());
	
	listString1.addAll(valString1);
	count++;

	} 
System.out.println("count is"+count);

%>
<% System.out.println("retailer data:" +listString1);%>



			<h1 align="center">Disaster Map</h1>
			<!--  <span id=curTime></span> -->
		</div>
		<br>
		<div style="border: solid 0px; float: left; margin-left: 480px;">


			<script>
			
			var coordsArr = <%=listString%>;
			var store = [];
			for(var i = 0; i < coordsArr.length; i++){
				store.push([coordsArr[i].Latitude, coordsArr[i].Longitude, coordsArr[i].City]);
				
			}
//alert("hai "+store);



var coordsArr1 = <%=listString1%>;
var store1 = [];
for(var j = 0; j < coordsArr1.length; j++){
	store1.push([coordsArr1[j].City, coordsArr1[j].RetailerName, coordsArr1[j].Revenue]);
}
//alert("retailer store is here " +store1);



<%
session.setAttribute("latlngcol", listString); 
session.setAttribute("retailercol", listString1); 
%>

<%pageContext.setAttribute("listString", listString);%>
	//document.getElementById("div_innerloading").style.display='NONE';
	</script>

		<div id="map" style="width: 827px; height: 696px; border: solid 1px;"></div>

		<script type="text/javascript">
			//var center = new google.maps.LatLng(7.3225, 21.16);
			var center = new google.maps.LatLng(20.5937, 78.9629);

				var map = new google.maps.Map(document.getElementById('map'), {
					zoom :5,
					center : center,
					mapTypeId : google.maps.MapTypeId.ROADMAP
				});

				var infowindow = new google.maps.InfoWindow();

				var markers = [];
				var bounds = new google.maps.LatLngBounds();
				for (var i = 0; i < store.length; i++) {
					//var dataPhoto = data.photos[i];
					var latLng = new google.maps.LatLng(store[i][0],
							store[i][1]);
				console.log("latlng is:" +latLng);
					bounds.extend(latLng);
					var marker = new google.maps.Marker({
						position : latLng
					});
					markers.push(marker);
						google.maps.event.addListener(marker,'mouseover',
									(function(marker, i) {
										return function() {
											//	alert(store[i][2]);
											//	alert(store[i][3]);

											var aa = store[i][2] + store[i][2];
											//	alert(aa);
				console.log("here is  looping inside:" +aa);

											var contentString = '<a href="#" id="'
													+ aa
													+ '" title="click to view passenger list" onclick="newtab()">'
													+ '    '
													+ store[i][2]
													+ '</a>';
											infowindow
													.setContent("<b>Welcome</b><br>   Location:"
															+ store[i][2]
															+ "  <br>View Retailerlist along with Revenues:"
															+ contentString); //infowindow.setContent("hello");
											infowindow.open(map, marker);
											//alert(contentString);

											test(aa);
										}
									})(marker, i));

				}

				var markerCluster = new MarkerClusterer(map, markers);
			google.maps.event.addDomListener(window, 'load', initialize);

			function newtab()
			{
				 window.open('table.jsp','_blank');
				 
/* 	 
 */		
		}
			function test(b) {

			}				//alert("hello"+b);

			
			function closeTo1() {

				//	alert("bye");
				document.getElementById("div_inner").style.display = 'NONE';
			}

			function closeTopnr() {

				//	alert("bye");
				document.getElementById("div_inner1").style.display = 'NONE';

			}

			function access() {

				alert("Access Denied");

			}

			 var xmlHttp;
			function closeTo3(a) {
			alert("into this");
				document.getElementById("div_inner").style.display = 'BLOCK';
				document.getElementById("div_inner_loading").style.display = 'BLOCK';
				//s	document.getElementById("div_inner1").style.display='NONE';

				if (typeof XMLHttpRequest != "undefined") {
					xmlHttp = new XMLHttpRequest();
				} else if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlHttp == null) {
					alert("Browser does not support XMLHTTP Request")
					return;
				}
				//alert(status1);

				var idconf = a.substring(13);
				var idconf1 = a.substring(0, 3);
				var idconf2 = a.substring(3, 13);

				//var url ="google_pnr.jsp?id="+idconf
				var url = "google_pnr.jsp?id=" + idconf + "&&id1=" + idconf1
						+ "&&id2=" + idconf2;
				xmlHttp.onreadystatechange = stateChange1;
				xmlHttp.open("GET", url, true);
				xmlHttp.send(null);
			} 

			function stateChange1() {

				if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
					//alert("inner1chanege");
					document.getElementById("div_inner1").innerHTML = xmlHttp.responseText
					//	alert("inner1chanege111");
					document.getElementById("div_inner_loading").style.display = 'NONE';

					//	alert("inner1chanege222");
					document.getElementById("div_inner1").style.display = 'BLOCK';
					//alert("inner1chanege3333");

					// 

				}
			}

			// map.fitBounds(bounds);
/* 
			var xmlHttp;
			function closeTo(a) {
				//alert("into this");

				document.getElementById("div_inner_loading").style.display = 'BLOCK';
				document.getElementById("div_inner").style.display = 'NONE';

				if (typeof XMLHttpRequest != "undefined") {
					xmlHttp = new XMLHttpRequest();
				} else if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlHttp == null) {
					alert("Browser does not support XMLHTTP Request")
					return;
				}
				//alert(status1);

				var idconf = a.substring(0, 3);

				//alert(idconf);

				var url = "google_query.jsp?id=" + idconf;

				xmlHttp.onreadystatechange = stateChange;
				xmlHttp.open("GET", url, true);
				xmlHttp.send(null);
			} */

			function stateChange() {

				if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
					//alert("inner");
					document.getElementById("div_inner").innerHTML = xmlHttp.responseText
					document.getElementById("div_inner_loading").style.display = 'NONE';
					//alert("inner blocking");
					document.getElementById("div_inner").style.display = 'BLOCK';
					//	alert("inner blocking done");

				

				}
			}
		</script>

	</div></div>

</body>
</html>




