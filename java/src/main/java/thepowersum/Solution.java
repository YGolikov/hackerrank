package thepowersum;

import java.io.*;
        import java.math.*;
        import java.security.*;
        import java.text.*;
        import java.util.*;
        import java.util.concurrent.*;
        import java.util.regex.*;

public class Solution {

    // Complete the powerSum function below.
    public static int powerSum(int start, int sum, int power){
        int success = 0;
        for (int i = start; i <= 1000; i++) {
            int res =  sum - ((int)Math.pow(i, power));
            if(res == 0){
                success++;
            }else if(res > 0){
                int innerRes = powerSum(i+1, res, power);
                success += innerRes;
            }else{
                break;
            }
        }
        return success;
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int x = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

        int n = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

        int result = powerSum(1, x, n);
        bufferedWriter.write(String.valueOf(result));
        bufferedWriter.newLine();

        bufferedWriter.close();

        scanner.close();
    }
}
