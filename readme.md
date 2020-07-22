
### Docker For BrainRender

This a dockerfile for running the BrainRender package in Jupyter notebooks.
https://github.com/BrancoLab/BrainRender

### Build Instructions

To build, use the following code in the command line while in the brainrender-docker folder

```
sudo docker build -t brainrender:0.4.0.0 .
```

### Running

You can run the image by using the following command:

```
sudo docker run -p 8888:8888 brainrender:0.4.0.0 jupyter notebook
```

This will create the jupyter notebook server and output the security token you need to copy into your web browser to access. Copy and paste and you should create a jupyter instance with brainrender already installed (make sure that port 8888 isn't already in use but something like another local jupyter notebook server).
