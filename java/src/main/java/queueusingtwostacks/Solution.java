package queueusingtwostacks;



import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;
import java.util.Stack;
import java.util.stream.Stream;


public class Solution {

    static class Queue<T> {
        private final Stack<T> enqueueStack = new Stack<>();
        private final Stack<T> dequeueStack = new Stack<>();

        private void moveStack() {
            while (!enqueueStack.isEmpty()) {
                dequeueStack.push(enqueueStack.pop());
            }
        }

        public void enqueue(T item) {
            enqueueStack.push(item);
        }

        public T dequeue() {
            if (dequeueStack.isEmpty()) {
                moveStack();
            }
            return dequeueStack.pop();
        }

        public void printFront() {
            if (dequeueStack.isEmpty()) {
                moveStack();
            }
            System.out.println(dequeueStack.peek());
        }
    }

    public static void main(String[] args) {

        Queue<Integer> queue = new Queue<>();

        Scanner in = new Scanner(System.in);
        var number = Integer.parseInt(in.nextLine());
        Stream
                .generate(in::nextLine)
                .limit(number)
                .forEach((s) -> {
                    var strings = s.split(" ");
                    switch (Integer.parseInt(strings[0])) {
                        case 1:
                            queue.enqueue(Integer.parseInt(strings[1]));
                            break;
                        case 2:
                            queue.dequeue();
                            break;
                        case 3:
                            queue.printFront();
                            break;
                    }
                });
    }
}
