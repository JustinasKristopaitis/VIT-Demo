//
//  ControlUnitDetailsView.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 25/10/2023.
//

import SwiftUI
import VehicleAPI

struct ControlUnitDetailsView: View {
    @ObservedObject var viewModel: ControlUnitsDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                statusCardView
                informationListView
            }
            .padding()
        }
        .navigationBarTitle("Control Unit Details", displayMode: .inline)
        .onAppear {
            viewModel.getFaultCount()
        }
    }

    @ViewBuilder
    private var statusCardView: some View {
        VStack {
            if viewModel.controlUnit.status == "faulty" {
                faultyCardView
            } else {
                successCardView
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    @ViewBuilder 
    private var faultyCardView: some View {
        NavigationLink(destination: blankScreenView) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Control unit is faulty")
                        .font(.title)
                    Text("\(viewModel.faultCaunt) faults found") // TODO: Where do I get the fault caunt as in AC?
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.blue)

            }
        }
    }

    @ViewBuilder
    private var successCardView: some View {
        VoltText("Healthy status", style: .header, customColor: .green)
    }

    @ViewBuilder
    private var informationListView: some View {
        VStack(alignment: .leading, spacing: 10) {
            informationRowView(title: "ID", value: viewModel.controlUnit.id)

            if let protocolName = viewModel.controlUnit.protocol {
                informationRowView(title: "Protocol", value: protocolName)
            }

            informationRowView(title: "Serial No.", value: viewModel.controlUnit.serialNumber)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func informationRowView(title: String, value: String) -> some View {
        HStack {
            VoltText(title, style: .medium, alignment: .leading)
            VoltText(value, style: .small, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var blankScreenView: some View {
        Text("")
    }

}

