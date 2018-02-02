<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import="com.google.gson.*"%>
<%@ page import="java.util.*" import="java.io.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>

<%-- <%@page include="googledashboard.jsp"%>
 --%>
<%--  <jsp:include page="googledashboard.jsp" flush="true"/>  
 --%>



<div id="log" style="display: none;">
	<%@ include file="googledashboard.jsp"%>
</div>
<%
  // Create an ArrayList with test data
 /*  ArrayList list = new ArrayList();
list.add("author1");
pageContext.setAttribute("list", list); */

 Object latlngcolobj = session.getAttribute("latlngcol");
 //System.out.println("getting latlngcol data in table.jsp:" +latlngcolobj);

 String s1 = latlngcolobj.toString();
// System.out.println("String value is s1: = " + s1);
 
 Object retailercolobj = session.getAttribute("retailercol");
 //System.out.println("getting retailercol data in table.jsp:" +retailercolobj);
 
 String s2 = retailercolobj.toString();
 //System.out.println("String value is s2: = " + s2);
 
 List<String> stringList1 = Arrays.asList(s1);
 //System.out.println("Stringlist1: = " + stringList1);
 
 List<String> stringList2 = Arrays.asList(s2);
 //System.out.println("Stringlist2: = " + stringList2);

// System.out.println("checking string list in  loop: = " + stringList1.get(0));
 try{
/*  JSONObject js = new JSONObject(s1);
 */ 
 // create a new Gson instance
 Gson gson = new Gson();
 // convert your list to json
 JSONObject json = new JSONObject();
 String jsonList = gson.toJson(stringList1);
 //json.put(stringList1);
 // print your generated json
 //System.out.println("jsonList: " + stringList1); 
 }
 catch(Exception e){
	 
 }

 /* 
 String[] stringarr1 = stringList1.toArray(new String[0]);
 System.out.println("fst table:"+Arrays.toString(stringarr1));
 
 */
 
 
 %>

<!DOCTYPE html>
<html>
<head>
<style>
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
	color: white;
}
</style>
	<script>



var coordsArr = <%=s1%>;
var coordsArr1 = <%=s2%>;
/* 
document.writeln("one" +coordsArr);
document.writeln("two" +coordsArr1); */


var retailerstore = [];
document.write('<table id="customers"><thead><th>City</th><th>RetailerName</th><th>Revenue</th></thead><tbody>');
for(var i = 0; i < coordsArr.length; i++)
{
	
	for(var j = 0; j < coordsArr1.length; j++)
		{
		
	   		if((coordsArr[i].City)==(coordsArr1[j].City))
			{			
			retailerstore.push([coordsArr1[j].City,coordsArr1[j].RetailerName,coordsArr1[j].Revenue]);
			document.write('<tr><td>'+coordsArr1[j].City+'</td><td>'+coordsArr1[j].RetailerName+'</td><td>'+coordsArr1[j].Revenue+'</td></tr>');
			}
	   		
		}

}
document.write('<tbody></table>');
</script>
</head>
<body>




</body>
</html>
