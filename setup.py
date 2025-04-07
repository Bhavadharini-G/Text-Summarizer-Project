
from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as f:
    long_description = f.read()


__version__ = "0.0.0"

REPO_NAME = "Text-Summarizer-Project"
AUTHOR_USER_NAME = "Bhavadharini-G"
SRC_REPO = "textSummarizer"
AUTHOR_EMAIL = "gunasekaranbhavadharini@gmail.com"




setup(
    name='your_project_name',
    version='0.1.0',
    packages=find_packages(),
    install_requires=[],
    include_package_data=True,
    description='A short description of your project',
    author='Your Name',
    author_email='you@example.com',
    url='https://github.com/yourusername/yourproject',
    classifiers=[
        'Programming Language :: Python :: 3',
        'Operating System :: OS Independent',
    ],
)
