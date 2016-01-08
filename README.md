# sonnenstube
Sonnenstube concert repo for visuals and so on.

Fork the project with a new branch using your name pls.

Use the latest version of Processing, the 3.0.1 because it contains all the new powerful libraries for video and sound management.

Installation of github:

1) install Homebrew that allows u to install many programs directly form the terminal:

	open the terminal, copy this and press enter:
	
	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	
2) install github by copying this in the terminal and press enter:

	$ brew install git
	
3) Done!


To connect to this repository, do the follow in the terminal:

1) choose a place where to store the repository
    $ cd homefolder/documents/projects    e.g.
    
2) copy the content of the github repository in your local folder:
    $ git clone https://github.com/MarcoLurati/sonnenstube.git
    
3) create your own branch to apply the modifications to the files:
    $ git checkout -b my_branch   (use your name pls, so git checkout -b marco e.g.)
    
4) now you can normally work to your sketches as usual from processing

5) once you are ready to share your sketch, go back to the terminal and do as follow:

  5.1) $ git status   (to see all the modifications/add u did)
  
  5.2) $ git add *    (to add all the modification) or  $ git add my_sketch/deep_space.pde   (to add just a specific file)
  
  5.3) $ git commit -m "message"  (insert a comment to keep track of what u did, e.g. "added keyboard control to the sketch")
  
  5.4) $ git push   (to push your files into the remote repository to made your files available for everybody)
  
  
Repeat the step 5) each time your sketch are ready to be released or with new working functionalities

Some other userful git commands:

$ git status    (see what's going on in your files)

$ git branch    (see all the branches used in the repository)

$ git checkout marco    (move to someone else branch to see his files and modifications. DON'T DO MODIFICATIONS AT THE MASTER BRANCH !!!)

$ git resed HEAD _path_to_file/sketch.pde   (remove a specific file if you don't want to publish it in the remote repository)

For questions, let me know.
