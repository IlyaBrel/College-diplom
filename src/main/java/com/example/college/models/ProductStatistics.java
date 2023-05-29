package com.example.college.models;

public class ProductStatistics {
    private Long productId;
    private int purchaseCount;
    private String size;

    public ProductStatistics(Long productId, String size) {
        this.productId = productId;
        this.size = size;
        this.purchaseCount = 0;

    }

    public Long getProductId() {
        return productId;
    }

    public int getPurchaseCount() {
        return purchaseCount;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public void incrementPurchaseCount() {
        this.purchaseCount++;
    }

}

