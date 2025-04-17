import 'package:flutter/material.dart';
import 'package:hamyon/controllers/wallet_controller.dart';
import 'package:hamyon/datacourse/local_datacourse.dart';
import 'package:hamyon/views/widgets/manage_wallet_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatacourse = LocalDatacourse();
  final walletController = WalletController();

  @override
  void initState() {
    super.initState();

    walletController.getWallets().then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton.icon(
        onPressed: () async {
          try {
            final result = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return ManageWalletDialog();
              },
            );

            if (result == true) {
              setState(() {});
            }
          } catch (e, s) {
            print(e);
            print(s);
          }
        },
        label: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text("20,000 so`m", style: TextStyle(fontSize: 28)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${localDatacourse.getBalance().toString()} so\'m',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '20%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    LinearProgressIndicator(
                      value: 0.4,
                      minHeight: 5,
                      backgroundColor: Colors.grey[300],
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amaliyotlar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (contex, index) {
                          final wallet = walletController.wallets[index];
                          return ListTile(
                            onTap: () async {
                              final result = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctx) {
                                  return ManageWalletDialog(eskiWallet: wallet);
                                },
                              );

                              if (result == true) {
                                setState(() {});
                              }
                            },
                            title: Text(wallet.title),
                            subtitle: Text(wallet.date.toString()),
                            trailing: Text("${wallet.cost.toString()} som"),
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 15),
                        itemCount: walletController.wallets.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String monthName(int month) {
    const months = [
      'yanvar',
      'fevral',
      'mart',
      'aprel',
      'may',
      'iyun',
      'iyul',
      'avgust',
      'sentabr',
      'oktabr',
      'noyabr',
      'dekabr',
    ];
    return months[month - 1];
  }
}
