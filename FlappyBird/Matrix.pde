import java.util.ArrayList;
import java.util.List;
//refactoring

class Matrix {
    public ArrayList<ArrayList<Double>> data;
    public int rows,cols;
    
    public Matrix(int rows,int cols) {
        data = new ArrayList<ArrayList<Double>>();
        this.rows = rows;
        this.cols = cols;
        for (int i = 0;i < rows;i++) {
			data.add(new ArrayList<Double>());
            for (int j = 0;j < cols;j++) {
                data.get(i).add(Math.random()*2-1);
            }
        }
    }

	public Matrix(Matrix to_copy){
		data = new ArrayList<ArrayList<Double>>(to_copy.data);
		rows = new Integer(to_copy.rows);
		cols = new Integer(to_copy.cols);
	}
    
    public void print() {
        // for (int i = 0;i < rows;i++) {
        //     for (int j = 0;j < cols;j++) {
        //         System.out.print(this.data.get(i).get(j) + " ");
        //     }
        //     System.out.println();
        // }
    }
    
    public void add(int scaler) {
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++) {
                this.data.get(i).set(j, this.data.get(i).get(j) + scaler);
            }
        }
    }
    
    public void add(Matrix m) {
        if (cols!= m.cols || rows!= m.rows) {
            System.out.println("Shape Mismatch");
            return;
        }
        
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++) {
                this.data.get(i).set(j, this.data.get(i).get(j) + m.data.get(i).get(j));
            }
        }
    }
    
    public ArrayList<Double> toArray() {
        ArrayList<Double> temp = new ArrayList<Double>();
        
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++) {
                temp.add(data.get(i).get(j));
            }
        }
        return temp;
    }
    
    public Matrix fromArray(ArrayList<Double> x) {
        Matrix temp = new Matrix(x.size(),1);
        for (int i = 0;i < x.size();i++)
            temp.data.get(i).set(0, x.get(i));
        return temp;
    }
    
    public  Matrix subtract(Matrix a, Matrix b) {
        Matrix temp = new Matrix(a.rows,a.cols);
        for (int i = 0;i < a.rows;i++) {
            for (int j = 0;j < a.cols;j++) {
                temp.data.get(i).set(j, a.data.get(i).get(j) - b.data.get(i).get(j));
            }
        }
        return temp;
    }
    
    public  Matrix transpose(Matrix a) {
        Matrix temp = new Matrix(a.cols,a.rows);
        for (int i = 0;i < a.rows;i++) {
            for (int j = 0;j < a.cols;j++)
                {
                temp.data.get(j).set(i, a.data.get(i).get(j));
            }
        }
        return temp;
    }
    
    public  Matrix multiply(Matrix a, Matrix b) {
        Matrix temp = new Matrix(a.rows,b.cols);
        for (int i = 0;i < temp.rows;i++) {
            for (int j = 0;j < temp.cols;j++) {
                double sum = 0;
                for (int k = 0;k < a.cols;k++) {
                    sum += a.data.get(i).get(k) * b.data.get(k).get(j);
                }
                temp.data.get(i).set(j, sum);
            }
        }
        return temp;
    }
    
    public void multiply(Matrix a) {
        for (int i = 0;i < a.rows;i++) {
            for (int j = 0;j < a.cols;j++) {
                this.data.get(i).set(j, this.data.get(i).get(j) * a.data.get(i).get(j));
            }
        }
    }
    
    public void multiply(Double a) {
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++) {
                this.data.get(i).set(j, this.data.get(i).get(j) * a);
            }
        }
    }

    public void mutate(Double rate){
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++) {
                double val = this.data.get(i).get(j);
                this.data.get(i).set(j, calculateMutation(val, rate));
            }
        }
    }

    private Double calculateMutation(Double val, Double rate){
        if (random(1) < rate){
            return val + randomGaussian() * .1;
        } else{
            return val;
        }
    }
    
    public void sigmoid() {
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++)
                this.data.get(i).set(j, 1.0 / (1 + Math.exp( - this.data.get(i).get(j)))); 
        }
    }
    
    public Matrix dsigmoid() {
        Matrix temp = new Matrix(rows,cols);
        for (int i = 0;i < rows;i++) {
            for (int j = 0;j < cols;j++)
                temp.data.get(i).set(j, this.data.get(i).get(j) * (1 - this.data.get(i).get(j)));
        }
        return temp;
    }
} 	
