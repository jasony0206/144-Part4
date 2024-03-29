<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<html>
<head>
<title>Search Results</title>
<link rel="stylesheet" type="text/css" href="keywordSearch.css">
<script type="text/javascript"  src="googleSuggest.js"></script>
</head>

<body>
	<form action="search">
	  	Query: <input type="text" id="query" name="q">
	  	<input type="hidden" name="numResultsToSkip" value="0">
	  	<input type="hidden" name="numResultsToReturn" value="30">
	  	<input type="submit" value="Submit">
	</form>
	<div id="suggestion"></div>
<%
	SearchResult[] searchResults = (SearchResult[]) request.getAttribute("searchResults");
	if (searchResults.length == 0)
		out.println("<h1>No search result found");
	else {
		for (SearchResult sr : searchResults) {
			String itemID = sr.getItemId();
			String itemLink = "<a href=\"item?itemid=" + itemID + "\">";
			out.println(itemLink + itemID + "</a>");
			out.println(sr.getName() + "<br>");
		}

		String q = request.getParameter("q");
		int prevNumResultsToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
		int nextNumResultsToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
		if (prevNumResultsToSkip >= 30) {
			prevNumResultsToSkip -= 30;
		}
		if (searchResults.length == 30) {
			nextNumResultsToSkip += 30;
		}

	    String prevUrl = String.format("search?q=%s&numResultsToSkip=%d&numResultsToReturn=30", q, prevNumResultsToSkip);
	    String nextUrl = String.format("search?q=%s&numResultsToSkip=%d&numResultsToReturn=30", q, nextNumResultsToSkip);
	    out.println("<br><a href=\"" + prevUrl + "\"><button>Previous</button></a>");
	    out.println("<a href=\"" + nextUrl + "\"><button>Next</button></a>");
	}
%>
</body>

</html>