import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:new_project/Home/eventList.dart';
import 'package:new_project/loginScreens/EmailSignUp.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {

  @override
  _CalenderPageState createState() => _CalenderPageState();
}


class _CalenderPageState extends State<CalenderPage> {



   CalendarController _controller=CalendarController();




  @override

  void initState() {
    super.initState();

  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          //TODO navigate to the add event screen
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventPage(_controller.selectedDay)));


        },
        child: Icon((FontAwesomeIcons.pen)),
         backgroundColor: Colors.red,
        splashColor: Colors.red,
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(onPressed: (){
          
          //TODO This is where the icon will return to the home page
          
        }, icon: Icon(FontAwesomeIcons.arrowCircleLeft)),
        actions: [
          IconButton(onPressed: (){
            
            //TODO this is where we will navigate to the event list page to edit it

           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>eventList()));
            
          }, icon: Icon(FontAwesomeIcons.stickyNote))
        ],
        title: Text('Calender'),

      ),
      body: SingleChildScrollView(
        
        child:Column(
          children: [
            Card(
              margin: EdgeInsets.all(8),
              elevation: 8,
              child: TableCalendar(
                initialCalendarFormat: CalendarFormat.twoWeeks,
                headerVisible: true,
                builders: CalendarBuilders(

                  selectedDayBuilder: (context, date, events) => Container(

                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),

                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
                weekendDays: [5],
                calendarStyle: CalendarStyle(

                  contentDecoration: BoxDecoration(
                    color: Colors.white,

                  ),

                    contentPadding: EdgeInsets.all(2),
                    //cellMargin: EdgeInsets.all(50),
                    markersColor: Colors.red
                ),
                headerStyle: HeaderStyle(


                  formatButtonPadding: EdgeInsets.all(10),
                  leftChevronPadding: EdgeInsets.all(3),
                  rightChevronPadding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin:AlignmentDirectional.topCenter ,
                        end: AlignmentDirectional.topEnd,
                        colors: [Colors.red,Colors.redAccent]
                    ),
                  ),
                  headerPadding: EdgeInsets.all(20),
                  headerMargin: EdgeInsets.only(bottom: 20,),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left,color: Colors.white,),
                  rightChevronIcon: Icon(Icons.chevron_right,color: Colors.white,),
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Prata',
                      color: Colors.white,
                      letterSpacing: 1.1,
                      fontSize: 19
                  ),

                ),

              ),
            ),
            SizedBox(height: 50,),



            
          ],
        )
        
      )
    );
  }


}


