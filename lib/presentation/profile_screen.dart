import 'package:flutter/material.dart';
import 'package:github_clone/data/model/user.dart';
import 'package:github_clone/presentation/viewModel/user_viewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO:watch와 read 차이. 초기화면에서 watch로 왜 안뜨는지
    final viewModel = context.watch<UserViewModel>();
    final user = viewModel.user;
    return Scaffold(
      body: ListView(
        children: [
          //ctrl + space
          TextFormField(
            //enter 로 검색 가능
            onFieldSubmitted: (String value) => viewModel.userSearch(value),
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
                hintText: "github 아이디로 검색해보세요",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ))),
          ),
          user != null
              ? Column(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.sizeOf(context).width * 0.5,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    Text(user.name),
                    Text(user.html_url.split('/')[3]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text('Type : '), Text(user.type)],
                    ),
                    Text(user.bio),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.group),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            user.followers.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Text('followers  ·  '),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            user.following.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Text('following')
                      ],
                    ),
                    user.location != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const Icon(Icons.location_on), Text(user.location)],
                          )
                        : const SizedBox(),
                    user.email != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const Icon(Icons.email), Text(user.email)],
                          )
                        : const SizedBox(),
                    user.company != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const Icon(Icons.apartment), Text(user.company)],
                          )
                        : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Icon(Icons.local_mall), const Text('Total Public repos : '), Text(user.publicRepos.toString())],
                    ),
                    user.blog != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.home),
                              // Text('Total Public repos : '),
                              Text(user.blog)
                            ],
                          )
                        : const SizedBox(),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              context.push('/');
            case 1:
              // TODO: 타입캐스팅해서 넘김
              context.push('/repo', extra: viewModel.user as User);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.purpleAccent,
              ),
              label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_mall), label: 'Repository'),
        ],
      ),
    );
  }
}
