package javastack;


import java.util.*;


public class Solution{

    public static Stack<Bracket> stack;

    public static BracketFactory bracketFactory = new BracketFactory();

    public static void printResult(boolean result){
        System.out.println(result);
    }

    public static void main(String []argh)
    {
        Scanner sc = new Scanner(System.in);


        while (sc.hasNext()) {
            String input = sc.next();

            char[] chars = input.toCharArray();

            stack = new Stack<>();

            Bracket firstBracket = bracketFactory.createBracket(chars[0]);

            if(firstBracket.getBracketDirection() == BracketDirection.close){
                printResult(false);
                continue;
            }else{
                stack.push(firstBracket);
            }

            interate(chars);


        }

    }

    public static void interate(char[] chars) {
        for (int i = 1; i < chars.length; i++) {
            Bracket currentBracket = bracketFactory.createBracket(chars[i]);
            if (currentBracket != null) {
                if (currentBracket.getBracketDirection() == BracketDirection.close) {
                    if (!stack.empty()) {
                        Bracket top = stack.peek();
                        if (top.getBracketType() == currentBracket.getBracketType()) {
                            stack.pop();
                        } else {
                            printResult(false);
                            return;
                        }
                    } else {
                        printResult(false);
                        return;
                    }
                } else {
                    stack.push(currentBracket);
                }
            }
        }
        if (stack.empty()) {
            printResult(true);
        } else {
            printResult(false);
        }
    }
}

class BracketFactory{
    public Bracket createBracket(char symbol){
        switch (symbol){
            case '{':
                return new Bracket(BracketType.curly, BracketDirection.open);

            case '}':
                return new Bracket(BracketType.curly, BracketDirection.close);

            case '(':
                return new Bracket(BracketType.round, BracketDirection.open);

            case ')':
                return new Bracket(BracketType.round, BracketDirection.close);

            case '[':
                return new Bracket(BracketType.square, BracketDirection.open);

            case ']':
                return new Bracket(BracketType.square, BracketDirection.close);

        }
        return null;
    }
}

class Bracket{
    private BracketType bracketType;
    private BracketDirection bracketDirection;

    public Bracket(BracketType bracketType, BracketDirection bracketDirection) {
        this.bracketType = bracketType;
        this.bracketDirection = bracketDirection;
    }

    public BracketType getBracketType() {
        return bracketType;
    }

    public BracketDirection getBracketDirection() {
        return bracketDirection;
    }

}

enum BracketType{
    round, square, curly
}

enum BracketDirection{
    open, close
}







