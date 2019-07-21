
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



</head>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  <script src='https://d3js.org/d3.v5.min.js'></script>
  <style>div {
  background-color:  #F1F3F3  ;  
  border: 1px dashed black    ;
  width:60%
}
.axis {
	font: 15px sans-serif;
}
.axis path,
.axis line {
  fill: none;
  stroke: none;
  stroke-width: 0;
  shape-rendering: crispEdges;
  opacity: 0.5;
}
.toolTip {
  position: absolute;
  display: none;
  min-width: 80px;
  height: auto;
  background: none repeat scroll 0 0 #ffffff;
  border: 1px solid #6F257F;
  padding: 14px;
  text-align: center;
}</style>
</head>
<body onload='init()' >
<div >

<script>
async function init() {

	  

	const data = await d3.csv('https://raw.githubusercontent.com/mkumar28/CSDV/master/HollywoodsMostProfitableStories.csv');
	//console.log(data)
	var margin = {top: 100, right: 20, bottom: 30, left: 100},
	    

	width = 960 - margin.left - margin.right,
	height = 500 - margin.top - margin.bottom;
	  console.log(height)
	  
	  
	var x = d3.scaleBand()
	          .range([0, width])
	          .padding(0.1);

	var y = d3.scaleLinear().domain([0,42])
	          .range([height, 0]);
	  
	var x_axis = d3.axisBottom().scale(x);

	var y_axis = d3.axisLeft().scale(y);
	
	var tooltip = d3.select("body").append("div").attr("class", "toolTip");

	 
	var svg = d3.select('div').append("svg")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom)
	  .append("g")
	    .attr("transform", 
	          "translate(" + margin.left + "," + margin.top + ")");
	  
	//Counting Genre  and number of movied made in each Genre
	 var counts= {};
	 data.forEach(function(r){
	      if (!counts[r.Genre]) {
	        counts[r.Genre] = 0;
	    }
	    counts[r.Genre]++;
	});
	  
	     
	          
	 var data1 = []
	     Object.keys(counts).forEach(function(key) {
	    data1.push({
	        Genre: key,
	        count: counts[key]
	    });
	});

	  
	  //Selecting color
	 var color = ["red", "Yellow", "steelblue", "orange", "green" , "blue"];
	  i=0;
	  data1.forEach(function(d){
	        d.color =  color[i];
	         i++
	               
	       });
	   
	   
	            
	  

	  // Scale the range of the data in the domains
	  x.domain(data1.map(function(d) { return d.Genre;}));
	  y.domain([0, d3.max(data1, function(d) { return  d.count})]);
	   
	  // append the rectangles for the bar chart
	  svg.selectAll(".bar")
	      .data(data1)
	      .enter().append("rect")
	      .attr("class", "bar")
	      .attr("x", function(d) { return x(d.Genre); })
	      .attr("width", x.bandwidth())
	      .attr("y", function(d) { return y(d.count); })
	      .attr("height", function(d) { return height - y(d.count) ; })
	      .attr("fill", function(d){return d.color})
	      .on("mousemove", function(d){
            tooltip
              .style("left", d3.event.pageX - 50 + "px")
              .style("top", d3.event.pageY - 70 + "px")
              .style("display", "inline-block")
              .html((d.Genre) + "<br>"  + (d.count));
        })
     .on("mouseout", function(d){ tooltip.style("display", "none");});

	  // add the x Axis
	  svg.append("g")
	      .attr("transform", "translate(0," + height + ")")
	      .call(d3.axisBottom(x));

	  // add the y Axis
	  svg.append("g")
	      .call(d3.axisLeft(y));
	 

	}
</script>
</div>

</body>
</html>  