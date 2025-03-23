package Model;

public class HealthPrediction {
    private String risk;
    private double probability;

    // Constructor
    public HealthPrediction(String risk, double probability) {
        this.risk = risk;
        this.probability = probability;
    }

    // Getters and Setters
    public String getRisk() { return risk; }
    public void setRisk(String risk) { this.risk = risk; }
    public double getProbability() { return probability; }
    public void setProbability(double probability) { this.probability = probability; }
}