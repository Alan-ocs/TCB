provider "google" {
    credentials = "${file("credentials.json")}"
    project = "SEUPROJETO"
    region = "us-east1-c"
}
