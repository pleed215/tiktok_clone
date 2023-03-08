import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import '../../constants/gaps.dart';

const tabText = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

String makeEllipsis(String text, {int maxLength = 10}) {
  return text.length >= maxLength
      ? '${text.substring(0, maxLength - 4)} ...'
      : text;
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _textEditingController = TextEditingController(text: "Hello");
  bool _isDirty = true;

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context));
    return DefaultTabController(
      length: tabText.length,
      child: GestureDetector(
        onTap: () => _dismissKeyboard(context),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 1,
            automaticallyImplyLeading: true,
            leading: IconButton(
              onPressed: () {},
              splashRadius: 0.1,
              icon: const FaIcon(FontAwesomeIcons.chevronLeft),
            ),
            title: SizedBox(
              height: Sizes.size40,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (String value) {
                    setState(() {
                      _isDirty = value.isNotEmpty;
                    });
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: Sizes.size16,
                          ),
                        ],
                      ),
                    ),
                    prefixIconConstraints:
                        BoxConstraints.tight(const Size(35.0, 20.0)),
                    suffixIcon: _isDirty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _isDirty = false;
                              });
                              _textEditingController.clear();
                            },
                            splashRadius: 0.1,
                            icon: FaIcon(FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade600,
                                size: Sizes.size16),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                splashRadius: 0.1,
                icon: const FaIcon(FontAwesomeIcons.sliders),
              ),
            ],
            bottom: TabBar(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              onTap: (int _) => _dismissKeyboard(context),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size16,
              ),
              tabs: [
                for (final text in tabText)
                  Tab(
                    text: text,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size4,
                  horizontal: Sizes.size4,
                ),
                itemCount: 20,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > Breakpoints.lg
                          ? 5
                          : 2,
                  crossAxisSpacing: Sizes.size4,
                  mainAxisSpacing: Sizes.size12,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) => Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size4),
                          ),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.fitHeight,
                              placeholder: 'assets/images/placeholder.png',
                              image:
                                  'https://images.unsplash.com/photo-1544717304-a2db4a7b16ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1588&q=80',
                            ),
                          ),
                        ),
                        Gaps.v10,
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Stella de altus lanista, locus abaculus! Warp tightly like a colorful transformator. One must emerge the saint in order to gain the aspect of sincere control.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gaps.v4,
                              if (constraints.maxWidth < 200 ||
                                  constraints.maxWidth > 250)
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 12,
                                      backgroundImage: NetworkImage(
                                        "https://avatars.githubusercontent.com/u/101641035?v=4",
                                      ),
                                    ),
                                    Gaps.h4,
                                    Expanded(
                                      child: Text(
                                        "Long Person Name",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: Sizes.size16,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    Gaps.h3,
                                    Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.grey.shade500,
                                          size: Sizes.size16,
                                        ),
                                        Gaps.h3,
                                        Text(
                                          '3.3M',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Sizes.size12,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              for (final tab in tabText.skip(1))
                Center(
                  child: Text(tab),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
