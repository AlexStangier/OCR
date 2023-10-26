from diagrams import Cluster, Diagram
from diagrams.gcp.storage import Storage
from diagrams.gcp.analytics import PubSub
from diagrams.gcp.compute import Run

with Diagram("Message Collecting and OCR Handling"):
    
    with Cluster("Image Source"):
        bucketInput = Storage("Image Bucket")
    
    with Cluster("Trigger"):
        pubsub = PubSub("Message Queue")

    with Cluster("OCR Handling"):
        
        with Cluster("Serverless"):
            cloudrun = Run("OCR")

        with Cluster("Persistence"):
            bucketOutput = Storage("Text Bucket")

    bucketInput >> pubsub >> cloudrun >> bucketOutput