import 'dart:typed_data';

import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => TicketState([]);

  @override
  Stream<TicketState> mapEventToState(TicketEvent event) async* {
    if (event is BuyTickets) {
      await TicketServices.saveTicket(event.userID, event.ticket);
      List<Ticket> tickets = state.tickets + [event.ticket];
      yield TicketState(tickets);
    } else if (event is GetTickets) {
      List<Ticket> tickets = await TicketServices.getTickets(event.userID);
      yield TicketState(tickets);
    }
  }
}
