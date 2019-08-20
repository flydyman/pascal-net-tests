# pascal-net-tests
Pascal Net Tests<br>
This is Initial commit, so there is nothing to do atm. Keep in mind: I've just started.<br>
furaidi<br>

<code>
 {$IFNDEF SOLARIS}<br>
         {$linklib libmysqlclient}<br>
     {$IFEND}<br>
     {$IFDEF UNIX}<br>
         {$linklib libz}<br>
         {$linklib libgcc}<br>
     {$IFEND}<br>
</code>
