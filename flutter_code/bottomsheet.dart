void _sortView() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.layers_outlined),
                    title: new Text('Dernier publié'),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.event_note_rounded),
                  title: new Text('Evenement'),
                  onTap: () => {},
                ),
                new ListTile(
                  leading: new Icon(Icons.date_range),
                  title: new Text('Date'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }