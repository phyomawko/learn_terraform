resource "local_file" "currency" {
    filename = "./currency.txt"
    content = var.currency["Myanmar"]
  
}