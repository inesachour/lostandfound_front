
import 'package:flutter/material.dart';
import 'package:lostandfound/models/comment.dart';
import 'package:lostandfound/settings/config.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

User? user;
String? idModified;



class addComment extends StatelessWidget {
  TextEditingController controller;
  String publication;
  BuildContext context;
  void Function() getPressed;

  addComment(this.context,
      {required this.controller,
      required this.publication,
      required this.getPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.06,
      width: context.width * 0.8,
      margin: EdgeInsets.all(5),
      child: TextFormField(
        onTap: () {
          if (!CommentCard.commentModif!) {}
        },
        controller: controller,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  final Future<SharedPreferences> _prefs =
                      SharedPreferences.getInstance();
                  final SharedPreferences prefs = await _prefs;
                  var commentOwner = prefs.getString("userId");
                  var ok = await CommentsService.getCommentService.addComment(
                    text: controller.text,
                    commentOwner: commentOwner!,
                    publication: publication,
                  );
                  getPressed();
                  controller.clear();
                }
              }),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.white,
          filled: true,
          focusColor: Colors.white,
          hintText: "Ecrire un commentaire",
        ),
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  Comment comment;
  static bool? commentModif = false;

  CommentCard({required this.comment, required this.onDelete});

  @override
  State<CommentCard> createState() => _CommentCardState();

  void Function() onDelete;
}

class _CommentCardState extends State<CommentCard> {
  String format(Comment comment) {
    int commentDay = DateTime.tryParse(comment.dateCreation)!.day;
    int commentMonth = DateTime.tryParse(comment.dateCreation)!.month;
    int commentYear = DateTime.tryParse(comment.dateCreation)!.year;
    int commentMin = DateTime.tryParse(comment.dateCreation)!.minute;
    int commentHour = DateTime.tryParse(comment.dateCreation)!.hour;
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    int currentHour = DateTime.now().hour;

    if (currentYear > commentYear && currentMonth >= commentMonth) {
      return (currentYear - commentYear).toString() + "y";
    } else if (currentMonth > commentMonth && currentDay >= commentDay) {
      return (currentMonth - commentMonth).toString() + "m";
    } else if ((currentDay - commentDay == 1 && currentHour >= commentHour) ||
        (currentDay - commentDay > 1)) {
      return (currentDay - commentDay).toString() + "d";
    } else {
      String cmtHour = commentHour.toString();
      String cmtMin = commentMin.toString();
      if (cmtHour.length == 1) {
        cmtHour = "0" + commentHour.toString();
      }
      if (cmtMin.length == 1) {
        cmtMin = "0" + commentMin.toString();
      }
      return cmtHour + ":" + cmtMin;
    }
  }

  Widget content = SizedBox();

  bool checked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(user != null ? user!.firstName : "User"),
            Text(
              format(widget.comment),
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        Text(
          widget.comment.text,
          style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
        )
      ],
    );
    checkUserOwner(widget.comment.commentOwner).then((value) {
      setState(() {
        checked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser(widget.comment.commentOwner);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
            radius: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: context.width * 0.55,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(6),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ]),
            child: content,
          ),
          checked
              ? PopupMenuButton(
                  color: Colors.grey.shade100,
                  shape: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  icon: Icon(
                    Icons.more_horiz,
                    size: 25,
                  ),
                  onSelected: (val) async {
                    if(val==1)
                      {
                        if (!CommentCard.commentModif!) {
                          setState(() {
                            CommentCard.commentModif = true;
                            idModified = widget.comment.id;
                            content = Focus(
                              onFocusChange: (focus) async {
                                if (!focus) {
                                  var res = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Voulez-vous sauvegarder les changements ?'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(
                                                  false); // dismisses only the dialog and returns false
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .all(Colors.red)),
                                            child: Text('Non'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pop(
                                                  true); // dismisses only the dialog and returns true
                                            },
                                            child: Text('Oui'),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .all(Colors.green
                                                    .shade300)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (res) {
                                    if (widget.comment.text.isNotEmpty) {
                                      await CommentsService
                                          .getCommentService
                                          .updateComment(widget.comment.id!,
                                          widget.comment.text);
                                    }

                                    setState(() {
                                      content = Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(user != null
                                                  ? user!.firstName
                                                  : "User"),
                                              Text(
                                                format(widget.comment),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Text(
                                            widget.comment.text,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                overflow:
                                                TextOverflow.ellipsis),
                                          )
                                        ],
                                      );
                                      CommentCard.commentModif = false;
                                      idModified = null;
                                    });
                                  }
                                }

                              },
                              child: TextFormField(
                                autofocus: true,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                initialValue: widget.comment.text,
                                onChanged: (val) {
                                  setState(() {
                                    widget.comment.text = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    child: Icon(Icons.send_rounded),
                                    onTap: () async {
                                      if (widget.comment.text.isNotEmpty) {
                                        await CommentsService
                                            .getCommentService
                                            .updateComment(
                                            widget.comment.id!,
                                            widget.comment.text);
                                        setState(() {
                                          content = Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(user != null
                                                      ? user!.firstName
                                                      : "User"),
                                                  Text(
                                                    format(widget.comment),
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                widget.comment.text,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                              )
                                            ],
                                          );

                                          CommentCard.commentModif = false;
                                        });
                                      }
                                    },
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            );
                          });
                        }
                      }
                    else if(val==2)
                      {
                        var res = await CommentsService.getCommentService
                            .deleteComment(widget.comment.id!);
                        widget.onDelete();
                        if(idModified == widget.comment.id)
                          {
                              idModified = null;
                              CommentCard.commentModif = false;
                          }
                      }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Modifier commentaire"),
                          textStyle: TextStyle(color: Colors.grey.shade700),
                          value: 1,
                        ),
                        PopupMenuItem(
                          textStyle: TextStyle(color: Colors.grey.shade700),
                          child: Text("Supprimer commentaire"),
                          value: 2,
                        ),
                      ])
              : SizedBox(
                  width: 48,
                )
        ],
      ),
    );
  }

  Future getUser(String commentOwner) async {
    user = await UsersService.findUser(userId: commentOwner);
  }

  Future<bool> checkUserOwner(String commentOwner) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey("userId")) {
      return sp.getString("userId") == commentOwner;
    }
    return false;
  }
}

class listComments extends StatefulWidget {
  BuildContext context;
  TextEditingController controller;
  String publicationId;
  static var getComments;

  listComments(this.context,
      {required this.controller, required this.publicationId});

  @override
  State<listComments> createState() => _listCommentsState();
}

class _listCommentsState extends State<listComments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listComments.getComments = CommentsService.getCommentService
        .findComments(publicationId: widget.publicationId);
    CommentCard.commentModif = false;
  }

  @override
  Widget build(BuildContext context) {
    print("list comments");
    return Column(
      children: [
        FutureBuilder<List<Comment>?>(
          future: listComments.getComments,
          builder:
              (BuildContext context, AsyncSnapshot<List<Comment>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var _comments = snapshot.data ?? [];
                return SingleChildScrollView(
                  child: SizedBox(
                    height: (_comments.length >= 2)
                        ? 100
                        : (80 * _comments.length.toDouble()),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          Comment comment = _comments[index];
                          return CommentCard(
                            comment: comment,
                            onDelete: () {
                              setState(() {
                                listComments.getComments = CommentsService
                                    .getCommentService
                                    .findComments(
                                        publicationId: widget.publicationId);
                              });
                            },
                          );
                        }),
                  ),
                );
              }
            }
          },
        ),
        addComment(
          widget.context,
          controller: widget.controller,
          publication: widget.publicationId,
          getPressed: () {
            setState(() {
              listComments.getComments = CommentsService.getCommentService
                  .findComments(publicationId: widget.publicationId);
            });
          },
        )
      ],
    );
  }
}
