**For alvaro: You asked me how to fix the shaders turning pink when compiling the game.**

# CG_FinalExam
Final Exam For Intro To Computer Graphics


# The Shaders
The game chosen to be recreated was Pacman. To Improve on its design, i decided to use shaders like The Flat Color Shader, Flat Color with Shadows, Scrolling Texture,The Hologram Shader and Rim Lighthing.

To Give Pacman his autentic look i decided to use a Flat Color with shaodws shader, that way he can be his usual Bright yellow but giving some 3d perspective with the utilization of shadows. it was super simple to implement and in the end i like how the result looks. The shader is a 2 pass shader where, first it give a shadow to the object and then in the 2 pass, it gives the object the ability to cast shadow.
<img width="1714" height="772" alt="image" src="https://github.com/user-attachments/assets/2595339c-e2bd-44c4-8969-1664cbd0b33c" />


For the Ghosts,Blinky, Pinky, Inky and Clyde, I utilized a rim shader with texture and glow to make them pop in the background. I felt this would be the best choice of shader to use since i could make them pop with the rim lighting and then add textures to them making them more ghostly. unfortunatelly i didnt had time to make them bodies and textures, leaving them as simple capsules.
<img width="1860" height="840" alt="image" src="https://github.com/user-attachments/assets/4ec2f316-261d-4411-b718-9fb2295038fa" />
<img width="764" height="586" alt="image" src="https://github.com/user-attachments/assets/8c2fc1cb-b9da-4fe4-8629-0f6564914846" />
<img width="784" height="650" alt="image" src="https://github.com/user-attachments/assets/e4b322e7-6091-4c5f-9481-4d345d1137b3" />
<img width="784" height="610" alt="image" src="https://github.com/user-attachments/assets/19662fe8-6410-43a1-b5b8-b428d1404810" />

For The background of the arena, I wanted to not be center of atention so i just used a simple color shader with no shadows so it wouldnt distract the player. They still can cast shadows but wont emmit them, making them a lesser distraction.

For the background of the game I utilized the Hologram shader since it is highly customizable, i ended up utilzing its property to give a suttle moving background to the game. I wish i had more time or access to my own studies because i would love to have made the background change color over time, but at the momment i lack this immidate knowledge. One thing i could do was give the lines a special glow that is controlled used via a Line Strengh float.
<img width="778" height="628" alt="image" src="https://github.com/user-attachments/assets/6ada24d6-2f05-4885-bb97-24e6e394038b" />


When i saw the game i had to re-create i had the perfect use for the scrolling Shader, i had an idea of making an hardcore pacman, and the scrolling shader would be, and was used to make a flame that would scroll, giving the idea of movement on the scene. I think the biggest modiffication i implemented to the shader was the possiblity of making it transparent, making so i could use images with transparancy and not obstruct the players visibility of the game.
<img width="770" height="632" alt="image" src="https://github.com/user-attachments/assets/a0043733-cf33-4ba9-9156-65df2a345c8a" />

# The Code
To create a cohesive game with a game loop i addpated the previously provided player code to count how many palletes were left and how many lifes the player still had before dying.
<img width="1160" height="394" alt="image" src="https://github.com/user-attachments/assets/d130e4d8-ead6-41b2-91d0-e29dcbff6099" />
<img width="1112" height="316" alt="image" src="https://github.com/user-attachments/assets/16d51697-dc99-4cd3-b30f-9379b7af3928" />
<img width="1352" height="1080" alt="image" src="https://github.com/user-attachments/assets/307d00af-abe9-46aa-93a8-1d5c77089f55" />

