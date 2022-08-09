package queensattack2;

import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;
import static java.lang.Math.abs;
import static java.lang.Math.min;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;

class Result {

    /*
     * Complete the 'queensAttack' function below.
     *
     * The function is expected to return an INTEGER.
     * The function accepts following parameters:
     *  1. INTEGER n
     *  2. INTEGER k
     *  3. INTEGER r_q
     *  4. INTEGER c_q
     *  5. 2D_INTEGER_ARRAY obstacles
     */

    public static int queensAttack(int n, int k, int r_q, int c_q, List<List<Integer>> obstacles) {
        var left = c_q - 1;
        var top = n - r_q;
        var down = r_q - 1;
        var right = n - c_q;
        var leftTop = min(left, top);
        var rightTop = min(right, top);
        var leftDown = min(left, down);
        var rightDown = min(right, down);

        for (List<Integer> obstacle : obstacles) {
            var r = obstacle.get(0);
            var c = obstacle.get(1);

            if(r_q == r){
                if(c < c_q){
                    left = min(c_q-c-1,left);
                }else{
                    right = min(c-c_q-1,right);
                }
            } else if (c_q == c) {
                if(r < r_q){
                    down = min(r_q-r-1,down);
                }else{
                    top = min(r-r_q-1,top);
                }
            } else if (abs(r_q-r) == abs(c_q-c)){
                if(r > r_q){
                    if(c < c_q){
                        leftTop = min(c_q-c-1,leftTop);
                    }else{
                        rightTop = min(c-c_q-1,rightTop);
                    }
                }else{
                    if(c < c_q){
                        leftDown = min(c_q-c-1,leftDown);
                    }else{
                        rightDown = min(c-c_q-1,rightDown);
                    }
                }
            }
        }
        return leftTop + rightTop + leftDown + rightDown + left + right + top + down;
    }
}

public class Solution {
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        String[] firstMultipleInput = bufferedReader.readLine().replaceAll("\\s+$", "").split(" ");

        int n = Integer.parseInt(firstMultipleInput[0]);

        int k = Integer.parseInt(firstMultipleInput[1]);

        String[] secondMultipleInput = bufferedReader.readLine().replaceAll("\\s+$", "").split(" ");

        int r_q = Integer.parseInt(secondMultipleInput[0]);

        int c_q = Integer.parseInt(secondMultipleInput[1]);

        List<List<Integer>> obstacles = new ArrayList<>();

        IntStream.range(0, k).forEach(i -> {
            try {
                obstacles.add(
                        Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
                                .map(Integer::parseInt)
                                .collect(toList())
                );
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        });

        int result = Result.queensAttack(n, k, r_q, c_q, obstacles);

        bufferedWriter.write(String.valueOf(result));
        bufferedWriter.newLine();

        bufferedReader.close();
        bufferedWriter.close();
    }
}
