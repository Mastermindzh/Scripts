<?php
	#runs and prints test information
    function addTest($method,$arr, $loops){
            echo '<tr>'.PHP_EOL;
            echo '	<td>'.$method.'</td>'.PHP_EOL;
            echo '	<td>'.PHP_EOL;
            
            #save the current starting time
            $start = microtime(true);
            for ($i = 0; $i < $loops; ++$i) {
                #find test method and run test
                switch($method){
                    case 'isset':
                        isset($a[rand(1, 1000000)]);
                    break;
                    case 'in_array':
                        in_array(rand(1, 1000000), $a);
                    break;
                    case 'array_key_exists':
                        array_key_exists(rand(1, 1000000), $a);
                    break;
                }
            }
            #calculate time the test took and print it out.
            $total_time = microtime(true) - $start;
            echo number_format($total_time,5).'s	</td>'.PHP_EOL;
            echo '</tr>'.PHP_EOL;
        }	
?>

<!DOCTYPE html>
<html lang="en">
	<head>
        <meta charset="utf-8"/>
		<title>php array find tests</title>
        <style>
        table {
            border-collapse: collapse;
        }
        
        table, td, th {
            border: 1px solid black;
            padding: 10px;
        }
        tr:first-child{
            background-color: #cecece;
            color white;
            font-weight: bold;
        }

        </style>
	</head>
	<body>
        <?php 
            $a = array();
            $start = microtime(true);	
            #fill up an array with random numbers
            for ($i = 0; $i < 40000; ++$i) {
                $v = rand(1, 1000000);
                $a[$v] = $v;
            }
            #find out how long the creation of the array took. (for laughs)
            $total_time = microtime(true) - $start;
            $loops = count($a);
            echo '<p>Creating an array with '.$loops.' items took: '.number_format($total_time,5).'s</p>'.PHP_EOL;
        ?>
        <table>
            <tr>
                <th>Method</th>
                <th>Speed</th>
            </tr>
            
        <?php
            #run all 3 tests
            addTest("isset",$a,$loops);
            addTest("in_array",$a,$loops);
            addTest("array_key_exists",$a,$loops);
        ?>
        </table>
    </body>
</html>
