#!/usr/bin/env ruby
# define a sh-bang env
# -*- Coding: UTF-8 -*- dealing with Chinese characters
#
# Designed by Baicai , QQ:70438244,  Mar 9, 2018
#
# This piece of code automatically adds index.html in given directory
# and its each sub dirs according to the file lists, files start with
# '.'(hidden) are excluded, index.html files are also excluded.
#
# before executing this file, the "Ruby language interpreter" must been installed ahead.
# to install Ruby,
# in Mac, Ruby is ready;
# in Ubuntu, just 'sudo apt-get install ruby'
# in CentOS, just 'sudo yum install ruby'
# after that, make this file executable 'chmod a+x indexmaker.rb'
# last, run './indexmaker.rb' in terminal.
# You got it!
# #
def listdir(dirname)
  myfile = File.new("#{dirname}/index.html", 'w') # linux
  puts "path = #{dirname}"
  Dir.chdir(dirname)
  mylist = Dir.entries(dirname)
  myfile.print <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style type="text/css">
:root {
  font-family: sans-serif;
}
img {
  border: 0;
}
th {
  text-align: start;
  white-space: nowrap;
}
th > a {
  color: inherit;
}
table[order] > thead > tr > th {
  cursor: pointer;
}
table[order] > thead > tr > th::after {
  display: none;
  width: .8em;
  margin-inline-end: -.8em;
  text-align: end;
}
table[order="asc"] > thead > tr > th::after {
  content: "\2193"; /* DOWNWARDS ARROW (U+2193) */
}
table[order="desc"] > thead > tr > th::after {
  content: "\2191"; /* UPWARDS ARROW (U+2191) */
}
table[order][order-by="0"] > thead > tr > th:first-child > a ,
table[order][order-by="1"] > thead > tr > th:first-child + th > a ,
table[order][order-by="2"] > thead > tr > th:first-child + th + th > a {
  text-decoration: underline;
}
table[order][order-by="0"] > thead > tr > th:first-child::after ,
table[order][order-by="1"] > thead > tr > th:first-child + th::after ,
table[order][order-by="2"] > thead > tr > th:first-child + th + th::after {
  display: inline-block;
}
table.remove-hidden > tbody > tr.hidden-object {
  display: none;
}
td {
  white-space: nowrap;
}
table.ellipsis {
  width: 100%;
  table-layout: fixed;
  border-spacing: 0;
}
table.ellipsis > tbody > tr > td {
  padding: 0;
  overflow: hidden;
  text-overflow: ellipsis;
}
/* name */
/* name */
th:first-child {
  padding-inline-end: 2em;
}
/* size */
th:first-child + th {
  padding-inline-end: 1em;
}
td:first-child + td {
  text-align: end;
  padding-inline-end: 1em;
}
/* date */
td:first-child + td + td {
  padding-inline-start: 1em;
  padding-inline-end: .5em;
}
/* time */
td:first-child + td + td + td {
  padding-inline-start: .5em;
}
.symlink {
  font-style: italic;
}
.dir ,
.symlink ,
.file {
  margin-inline-start: 20px;
}
.dir::before ,
.file > img {
  margin-inline-end: 4px;
  margin-inline-start: -20px;
  max-width: 16px;
  max-height: 16px;
  vertical-align: middle;
}
.dir::before {
  content: url(resource://gre/res/html/folder.png);
}
.block {
  display: none;
}
  </style>
   <script type="application/javascript">
        'use strict';
        var gTable, gOrderBy, gTBody, gRows, gUI_showHidden;
        document.addEventListener("DOMContentLoaded", function() {
            gTable = document.getElementsByTagName("table")[0];
            gTBody = gTable.tBodies[0];
            if (gTBody.rows.length < 2)
                return;
            gUI_showHidden = document.getElementById("UI_showHidden");
            var headCells = gTable.tHead.rows[0].cells,
                hiddenObjects = false;
            function rowAction(i) {
                return function(event) {
                    event.preventDefault();
                    orderBy(i);
                }
            }
            for (var i = headCells.length - 1; i >= 0; i--) {
                var anchor = document.createElement("a");
                anchor.href = "";
                anchor.appendChild(headCells[i].firstChild);
                headCells[i].appendChild(anchor);
                headCells[i].addEventListener("click", rowAction(i), true);
            }
            if (gUI_showHidden) {
                gRows = Array.slice(gTBody.rows);
                hiddenObjects = gRows.some(row => row.className == "hidden-object");
            }
            gTable.setAttribute("order", "");
            if (hiddenObjects) {
                gUI_showHidden.style.display = "block";
                updateHidden();
            }
        }, "false");
        function compareRows(rowA, rowB) {
            var a = rowA.cells[gOrderBy].getAttribute("sortable-data") || "";
            var b = rowB.cells[gOrderBy].getAttribute("sortable-data") || "";
            var intA = +a;
            var intB = +b;
            if (a == intA && b == intB) {
                a = intA;
                b = intB;
            } else {
                a = a.toLowerCase();
                b = b.toLowerCase();
            }
            if (a < b)
                return -1;
            if (a > b)
                return 1;
            return 0;
        }
        function orderBy(column) {
            if (!gRows)
                gRows = Array.slice(gTBody.rows);
            var order;
            if (gOrderBy == column) {
                order = gTable.getAttribute("order") == "asc" ? "desc" : "asc";
            } else {
                order = "asc";
                gOrderBy = column;
                gTable.setAttribute("order-by", column);
                gRows.sort(compareRows);
            }
            gTable.removeChild(gTBody);
            gTable.setAttribute("order", order);
            if (order == "asc")
                for (var i = 0; i < gRows.length; i++)
                    gTBody.appendChild(gRows[i]);
            else
                for (var i = gRows.length - 1; i >= 0; i--)
                    gTBody.appendChild(gRows[i]);
            gTable.appendChild(gTBody);
        }
        function updateHidden() {
            gTable.className = gUI_showHidden.getElementsByTagName("input")[0].checked ?
                "" :
                "remove-hidden";
        }
    </script>
  <link rel="stylesheet" media="screen, projection" type="text/css" href="chrome://global/skin/dirListing/dirListing.css">
  <link rel="icon" type="image/png" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8%2F9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAjFJREFUeNqsU8uOElEQPffR3XQ3ONASdBJCSBxHos5%2B3Bg3rvkCv8PElS78gPkO%2FATjQoUdO2ftrJiRh6aneTb9sOpC4weMN6lcuFV16pxDIfI8x12OYIDhcPiu2Wx%2B%2FHF5CW1Z6Jyegt%2FTNEWSJIjjGFEUIQxDrFYrWFSzXC4%2FdLvd95pRKpXKy%2BpRFZ7nwaWo1%2BsGnQG2260BKJfLKJVKGI1GEEJw7ateryd0v993W63WEwjgxfn5obGYzgCbzcaEbdsIggDj8Riu6z6iUk9SYZMSx8W0LMsM%2FSKK75xnJlIq80anQXdbEp0OhcPJ0eiaJnGRMEyyPDsAKKUM9clkYoDo3SZJzzSdp0VSKYmfV1co%2Bz580kw5KDIM8RbRfEnUf1HzxtQyMAGcaGruTKczMzEIaqhKifV6jd%2BzGQQB5llunF%2FM52BizC2K5sYPYvZcu653tjOM9O93wnYc08gmkgg4VAxixfqFUJT36AYBZGd6PJkFCZnnlBxMp38gqIgLpZB0y4Nph18lyWh5FFbrOSxbl3V4G%2BVB7T4ajYYxTyuLtO%2BCvWGgJE1Mc7JNsJEhvgw%2FQV4fo%2F24nbEsX2u1d5sVyn8sJO0ZAQiIYnFh%2BxrfLz%2Fj29cBS%2FO14zg3i8XigW3ZkErDtmKoeM%2BAJGRMnXeEPGKf0nCD1ydvkDzU9Jbc6OpR7WIw6L8lQ%2B4pQ1%2FlPF0RGM9Ns91Wmptk0GfB4EJkt77vXYj%2F8m%2B8y%2FkrwABHbz2H9V68DQAAAABJRU5ErkJggg%3D%3D">
</head>
<body>
<h1>
EOF
  myfile.puts "Index of: #{Dir.pwd.split('/').last}"
  myfile.puts "</h1>"
  myfile.print <<EOF
  <table class="remove-hidden">
    <thead>
    <tr class="block">
        <th>sort</th>
    </tr>
    </thead>
    <tbody>
EOF
  mylist.sort_by!(&:downcase)
  mylist.each do |my|
    # don't list hidden files and index.html file
    next if my.start_with?('.') || my == "index.html"
    # dir must be a full path name
    if File.directory?(dirname + '/' + my)
      myfile.puts "<tr><td sortable-data=\"#{my}\"><table class=\"ellipsis\"><tbody><tr><td><a class=\"dir\" href =\"#{my}\">#{my}</a></td></tr></tbody></table></td></tr>"
      newfilename = dirname +  '/' + my
      listdir newfilename
    else
      myfile.puts "<tr><td sortable-data=\"#{my}\"><table class=\"ellipsis\"><tbody><tr><td><a class=\"file\" href =\"#{my}\"><img src=\"moz-icon://#{my}?size=16\" alt=\"File:\">#{my}</a></td></tr></tbody></table></td></tr>"
    end
  end
  myfile.print <<EOL
    </tbody>
  </table>
</body>
</html>
EOL
  myfile.close
end
# to call, make sure dirname is correct
# dirname = "/usr/share/nginx/html/2413" # linux nginx web root dir
dirname = "/var/www/html/2413" # linux apache web root dir
# dirname = "/Users/baicai/Downloads" # mac user dir
listdir dirname
