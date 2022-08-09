package coinchange;

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

class Result {

    /*
     * Complete the 'getWays' function below.
     *
     * The function is expected to return a LONG_INTEGER.
     * The function accepts following parameters:
     *  1. INTEGER n
     *  2. LONG_INTEGER_ARRAY c
     */

    private static class ComputeCache {
        private int n;
        private List<Integer> c;

        public ComputeCache(int n, List<Integer> c) {
            this.n = n;
            this.c = c;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            ComputeCache that = (ComputeCache) o;
            return n == that.n &&
                    Objects.equals(c, that.c);
        }

        @Override
        public int hashCode() {
            return Objects.hash(n, c);
        }
    }

    private static Map<ComputeCache, Long> computedCacheMap = new HashMap<>();


    public static long getWays(int n, List<Integer> c) {

        Long cache = computedCacheMap.get(new ComputeCache(n, c));
        if (cache != null) {
            return cache;
        }

        if (c.isEmpty()) {
            return 0;
        }
        if (n == 0) {
            return 1;
        }
        if (n < 0) {
            return 0;
        }

        long r = getWays(n - c.get(0), c) + getWays(n, c.subList(1, c.size()));

        computedCacheMap.put(new ComputeCache(n, c), r);

        return r;
    }

}

public class Solution {
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        String[] firstMultipleInput = bufferedReader.readLine().replaceAll("\\s+$", "").split(" ");

        int n = Integer.parseInt(firstMultipleInput[0]);

        int m = Integer.parseInt(firstMultipleInput[1]);

        List<Long> c = Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
                .map(Long::parseLong)
                .collect(toList());

        // Print the number of ways of making change for 'n' units using coins having the values given by 'c'

        long ways = Result.getWays(n, c.stream().map(Long::intValue).collect(Collectors.toList()));

        bufferedWriter.write(String.valueOf(ways));
        bufferedWriter.newLine();

        bufferedReader.close();
        bufferedWriter.close();
    }
}
