  showConfirmDialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: Stack(
              children: [
                Container(
                  height: 300,
                ),
                Container(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Center(
                                child: Text(
                              "some text",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                           
                          ElevatedButton(
                            onPressed: () {
                              gotoReplace(context, "/confirmcode");
                            },
                            child: Text("D'accord"),
                            style: ElevatedButton.styleFrom(
                                primary: COLORPRIMARY,
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context) * 0.21,
                                    vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Annuler")],
                              ))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      });
