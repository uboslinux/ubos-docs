Raspberry Pi (any model)
========================

How to use the Raspberry Pi's camera
------------------------------------

Using the Raspberry Pi's official camera while running UBOS is quite simple, as everything
you need is pre-installed on UBOS for the Raspberry Pi.

However, you need to make one change in one file, which is to allocate more of the
Pi's limited memory to graphics. We could have pre-configured that, but we figure most
people running the Pi do not use a camera, and much rather have access to all of the RAM.

To make this change, become root and open the file with your favorite editor, such as
``vi``:

.. code-block:: none

   > sudo su
   # vi /boot/config.txt

Add the very end of the file, add the following content:

.. code-block:: none

   gpu_mem_512_=128
   gpu_mem_256_=128
   start_file=start_x.elf
   fixup_file=fixup_x.dat

(In ``vi``, you would hit ``G`` to go to the end of the file, then hit ``A`` to append,
then type the above text. When done, hit Escape to leave editing mode, and ``ZZ`` to save
and quit the editor.)

Then, shutdown your Pi:

.. code-block:: none

   > sudo shutdown -h now

and physically connect the camera to the Pi with the appropriate cable. Re-apply power,
and once the Pi has booted, you can take a picture with:

.. code-block:: none

   `/opt/vc/bin/raspistill -o mypicture.jpg`

or take a video with:

.. code-block:: none

   `/opt/vc/bin/raspivid -o myvideo.mpg`.

Invoke those commands without arguments to see their many options.
