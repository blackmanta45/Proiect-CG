public class NeuralNetwork
{
    public Matrix weights_ih, weights_ho, bias_h, bias_o;
    public double l_rate = 0.01;
    
    public NeuralNetwork(int i, int h, int o) {
        weights_ih = new Matrix(h, i);
        weights_ho = new Matrix(o, h);
        
        bias_h = new Matrix(h, 1);
        bias_o = new Matrix(o, 1);
    }

	public NeuralNetwork(NeuralNetwork to_copy){
		weights_ho = new Matrix(to_copy.weights_ho);
		weights_ih = new Matrix(to_copy.weights_ih);

		bias_h = new Matrix(to_copy.bias_h);
		bias_o = new Matrix(to_copy.bias_o);
	}
    
    public List<Double> predict(ArrayList<Double> x_matrix) {
        Matrix input = matrix.fromArray(x_matrix);
        Matrix hidden = matrix.multiply(weights_ih, input);
        hidden.add(bias_h);
        hidden.sigmoid();
        
        Matrix output = matrix.multiply(weights_ho, hidden);
        output.add(bias_o);
        output.sigmoid();
        
        return output.toArray();
    }
    
    
    public void fit(ArrayList<ArrayList<Double>> x_matrix, ArrayList<ArrayList<Double>> y_matrix, int epochs) {
        for (int i = 0; i < epochs; i++) {
            int sampleN = (int)(Math.random() * x_matrix.size());
            this.train(x_matrix.get(sampleN), y_matrix.get(sampleN));
        }
    }
    
    public void train(ArrayList<Double> x_matrix, ArrayList<Double> y_matrix) {
        Matrix input = matrix.fromArray(x_matrix);
        Matrix hidden = matrix.multiply(weights_ih, input);
        hidden.add(bias_h);
        hidden.sigmoid();
        
        Matrix output = matrix.multiply(weights_ho, hidden);
        output.add(bias_o);
        output.sigmoid();
        
        Matrix target = matrix.fromArray(y_matrix);
        
        Matrix error = matrix.subtract(target, output);
        Matrix gradient = output.dsigmoid();
        gradient.multiply(error);
        gradient.multiply(l_rate);
        
        Matrix hidden_T = matrix.transpose(hidden);
        Matrix who_delta = matrix.multiply(gradient, hidden_T);
        
        weights_ho.add(who_delta);
        bias_o.add(gradient);
        
        Matrix who_T = matrix.transpose(weights_ho);
        Matrix hidden_errors = matrix.multiply(who_T, error);
        
        Matrix h_gradient = hidden.dsigmoid();
        h_gradient.multiply(hidden_errors);
        h_gradient.multiply(l_rate);
        
        Matrix i_T = matrix.transpose(input);
        Matrix wih_delta = matrix.multiply(h_gradient, i_T);
        
        weights_ih.add(wih_delta);
        bias_h.add(h_gradient);
    }
}
