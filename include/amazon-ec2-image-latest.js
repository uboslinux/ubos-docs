var thisScript = document.getElementById( 'ubos-amazon-ec2-image-latest' );
var parent     = thisScript.parentElement;
var imageDiv   = document.createElement( 'div' );

imageDiv.id        = 'ubos-amazon-ec2-image-latest';
imageDiv.style     = 'text-align: center';
imageDiv.innerHTML = '<a href="UBOS_AWS_IMAGE_URL"><img src="https://ubos.net/images/aws_logo_179x109.gif" alt="[EC2 image]"/></a>';

parent.replaceChild( imageDiv, thisScript );

