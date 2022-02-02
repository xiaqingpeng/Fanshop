import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_card.dart';

class RedPacket extends StatefulWidget {
  const RedPacket({Key? key}) : super(key: key);

  @override
  State<RedPacket> createState() => _RedPacketState();
}

class _RedPacketState extends State<RedPacket>
    with SingleTickerProviderStateMixin {
  Animation<double>? scaleAnimation;
  AnimationController? scaleController;
  @override
  void initState() {
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    scaleAnimation = Tween(begin: 1.0, end: 2.0).animate(
        CurvedAnimation(parent: scaleController!, curve: Curves.easeInOut));
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Widget FrontWidget() {
    return Container(
      width: 300,
      height: 360,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Text(
              '新年發發發',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(251, 253, 197, 1),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: ScaleTransition(
                scale: scaleAnimation!,
                child: SizedBox(
                  child: Image.asset(
                    "assets/images/hongbao.png",
                    fit: BoxFit.contain,
                    width: 64,
                    height: 64,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget BackWidget() {
    return Container(
      width: 300,
      height: 360,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            left: 0,
            right: 0,
            top: 30,
            child: Text(
              '恭喜你获得3个红包',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 248, 234, 1),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 60,
              child: SizedBox(
                height: 252,
                child: MediaQuery.removePadding(
                  context: context,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children:  const [
                        CustomCard(
                          child: ListTile(
                            title: Text('大红包'),
                            subtitle: Text('2022-1-1至2022-12-31'),
                            trailing: Text(
                              '99.9元',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        CustomCard(
                          child: ListTile(
                            title: Text('大红包'),
                            subtitle: Text('2022-1-1至2022-12-31'),
                            trailing: Text(
                              '49.9元',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        CustomCard(
                          child: ListTile(
                            title: Text('大红包'),
                            subtitle: Text('2022-1-1至2022-12-31'),
                            trailing: Text(
                              '29.9元',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        CustomCard(
                          child: ListTile(
                            title: Text('大红包'),
                            subtitle: Text('2022-1-1至2022-12-31'),
                            trailing: Text(
                              '19.9元',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // FrontWidget(),
          BackWidget(),
        ],
      ),
    );
  }
}
