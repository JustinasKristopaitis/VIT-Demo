//
//  OverviewView.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 20/10/2023.
//

import SwiftUI
import VehicleAPI

struct ControlUnitsView: View {
    @ObservedObject var viewModel: ControlUnitsViewModel

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.data.isEmpty {
                emptyListView
            } else if viewModel.isFailed {
                loadingFailedView
            } else {
                VStack {
                    Picker("Sort By:", selection: $viewModel.sortedBy) {
                        ForEach(ControlUnitsViewModel.SortOption.allCases, id: \.self) { sortOption in
                            Text(sortOption.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                List {

                    ForEach(viewModel.sortedItems) { unit in
                            NavigationLink(
                                destination: ControlUnitDetailsView(
                                    viewModel: ControlUnitsDetailsViewModel(
                                        vehicleDataLoading: VehicleDataLoader(),
                                        controlUnit: unit
                                    )
                                )
                            ) {
                                loadedListView(controlUnit: unit)
                            }
                        }
                    }
                }
                .background(Color.blue)
                .navigationBarTitle("Control Units", displayMode: .large)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            Task {
                viewModel.loadData(forceLoad: false)
            }
        }
        .refreshable {
            Task {
                viewModel.loadData(forceLoad: true)
            }
        }
    }


    @ViewBuilder
    private var emptyListView: some View {
        VStack {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundColor(Color.secondary)

            Text("No Control Units Found")
                .font(.title)
                .foregroundColor(Color.secondary)
        }
        .navigationBarTitle("", displayMode: .inline)
    }

    @ViewBuilder
    private func loadedListView(controlUnit: ControlUnitData) -> some View {
        HStack {
            AsyncImage(
                url: URL(string: controlUnit.imageUrl),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90)
                },
                placeholder: {
                    ProgressView()
                }
            )

            Spacer()

            VStack(alignment: .leading, spacing: 5) {
                VoltText(controlUnit.status.uppercased(), style: .medium)
                VoltText(controlUnit.name, style: .small, alignment: .leading)
                VoltText(controlUnit.id, style: .custom(.blue.opacity(0.6), .caption), alignment: .leading)
            }
        }
        .navigationBarTitle("Control units", displayMode: .inline)
    }

    @ViewBuilder
    private var loadingFailedView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)

            VoltText("Loading Failed", style: .warning)
            VoltText("Unable to load control units. Please check your connection and try again.", style: .medium)
            VoltButton("Retry") {
                Task {
                    viewModel.loadData(forceLoad: true)
                }
            }
        }
    }
}

#Preview {
    ControlUnitsView(viewModel: ControlUnitsViewModel(vehicleDataLoader: VehicleDataLoader()))
}
