package treehuffmandecoding;

class Result {

    class Node {
        public int frequency; // the frequency of this tree
        public char data;
        public Node left, right;
    }

    public String string;
    public Node node;

    public Result(String string, Node node) {
        this.string = string;
        this.node = node;
    }


    void printTree(Node root, int deep){
        for (int i=0; i<deep; i++){
            System.out.print("___");
        }
        System.out.println(root.data + " : " + root.frequency);
        if(root.left != null){
            printTree(root.left, deep + 1);
        }
        if(root.right != null){
            printTree(root.right, deep + 1);
        }
    }


    void decode(String s, Node root) {

        Result result = s
                .chars()
                .mapToObj(c -> (char) c)
                .reduce(
                        new Result("", root),
                        (res, c) -> {
                            Node node = res.node;
                            Node checkNode;
                            if (c == '0') {
                                checkNode = node.left;
                            } else {
                                checkNode = node.right;
                            }
                            if(checkNode.data == '\0') {
                                return new Result(res.string, checkNode);
                            } else {
                                return new Result(res.string + checkNode.data, root);
                            }
                        },
                        (a, b) -> {
                            throw new RuntimeException("Does not support parallel streams");
                        }
                );
        System.out.println(result.string);

    }
}

