GeoPKI-Server
=============

This is an implementation of the GeoPKI system log and hash tree server.
A running test implementation is at: http://geopki.herokuapp.com/

GeoPKI publication: https://sparrow.ece.cmu.edu/group/pub/kim_gligor_perrig_GeoPKI.pdf


<h3>Notes</h3>
<ul>
<li>Merkle hash tree is updated automatically when leaves are created, modified, or destroyed</li>

<li>Leafs are the actual entities that are part of the MHT. They can be viewed at /leafs</li>

<li>Nodes are the hash values in the tree. They can be viewed at /nodes. These should not be edited or modified, as they are automatically generated.</li>
</ul>

<h3>API</h3>
The API for the GeoPKI server is as follows:

http://serverurl/geopki?lat=123.1&lon=123.1&alt=123.1
where "123.1" is just a dummy value.

The URL supports postitive/negative decimal values for latitude and longitude as well as altitude.

This will return "null" if nothing is found or if the syntax is incorrect.

It will return a JSON array of the intermediate hash values needed to verify the root in the order they need to be hashed, including whether they are right or left children, followed by the root. The entity that is attempting to be verified is NOT included.

example:
["4becfcddc10a2cb960bb482a286302f5d588c516","rchild","d7fb1e7ba05d5eb929ec3d62ed5a6f171a531428","root"]