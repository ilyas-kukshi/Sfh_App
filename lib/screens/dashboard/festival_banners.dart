import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/festival/festival_banner_model.dart';

class FestivalBanners extends StatefulWidget {
  final FestivalBannerModel festival;
  const FestivalBanners({super.key, required this.festival});

  @override
  State<FestivalBanners> createState() => _FestivalBannersState();
}

class _FestivalBannersState extends State<FestivalBanners> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/displayProductsByTags',
          arguments: widget.festival.tags),
      child: Container(
        color: const Color(0xffFCAB64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.festival.title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff0D1B2A),
                          )),
                  const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 420,
              child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 200,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  children: widget.festival.tags != null
                      ? widget.festival.tags!
                          .map((tag) => GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/displayProductsByTags',
                                    arguments: [tag]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: tag.imageUri!,
                                          height: 130,
                                          alignment: Alignment.center,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          tag.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                      : []),
            ),
          ],
        ),
      ),
    );
  }

  // Widget displayTags() {
  //   return widget.festival["tags"] != null
  //       ? widget.festival["tags"].forEach((tag) {
  //           return Text(tag["name"]);
  //         })
  //       : const Offstage();
  // }
}
