from huggingface_hub import upload_folder, create_repo
from textSummarizer.config.configuration import ConfigurationManager

def upload_model_to_huggingface():
    config = ConfigurationManager().get_model_evaluation_config()

    # Your Hugging Face repo details
    repo_name = "bhavadharinig/text-summarizer-custom"

    # Create the repository on Hugging Face if it doesn’t already exist
    print(f"🔄 Creating or accessing repo: {repo_name}")
    create_repo(repo_name, exist_ok=True)

    # Upload the model folder
    print("🚀 Uploading model...")
    upload_folder(
        repo_id=repo_name,
        folder_path=str(config.model_path),
        path_in_repo="model"
    )

    # Upload the tokenizer folder
    print("🚀 Uploading tokenizer...")
    upload_folder(
        repo_id=repo_name,
        folder_path=str(config.tokenizer_path),
        path_in_repo="tokenizer"
    )

    print(f"✅ Upload complete! View your model at: https://huggingface.co/{repo_name}")

if __name__ == "__main__":
    upload_model_to_huggingface()
