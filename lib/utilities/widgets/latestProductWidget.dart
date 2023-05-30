import 'package:flutter/material.dart';

class LatestProduct extends StatelessWidget {
  const LatestProduct({
    super.key,
    required this.name,
    required this.height,
    required this.images,
    required this.width,
  });

  final List<String> name;
  final double height;
  final List<String> images;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  for (int i = 0; i < 6; i++)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name[i],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.black,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    content: SizedBox(
                                      height: height * 0.43,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            child: Image(
                                              image: NetworkImage(images[i]),
                                              fit: BoxFit.fill,
                                              height: height * 0.29,
                                              width: double.maxFinite,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRect(
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: 'Description:- ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 16),
                                                      children: const [
                                                    TextSpan(
                                                        text:
                                                            'In literary theory, a text is any object that can be "read", whether this object is a work of literature, a street sign, an arrangement of buildings on a city block, or styles of clothing.',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ])),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Add to Cart'))
                                    ]);
                              });
                        },
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.29,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(images[i]),
                                  fit: BoxFit.fill)),
                          child: Center(
                            child: Text(
                              name[i],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}
