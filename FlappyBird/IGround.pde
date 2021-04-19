public interface IGround {
    
    public void fillGroundTop();

    public void fillGroundBottom();
    
    public void updateLocation();

    public void swap(int index1, int index2);
    
    public void addOne(int i);
    
    public float getHeight();
}